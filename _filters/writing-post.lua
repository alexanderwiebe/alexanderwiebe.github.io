-- Turns a Markdown post under writing/ into a site page with an agent layer.
--
--   1. Wraps the post in the site chrome (masthead, crumb, title, dek) so posts can be plain
--      Markdown instead of hand-written HTML like the other pages.
--   2. Embeds the post's `agent:` frontmatter as <script type="application/json" id="post-agent">.
--      _includes/webmcp-post.html reads it to register the post's WebMCP tools, and the site-wide
--      get_post tool reads it from other pages. Readers never see it.
--
-- Acts only on documents under writing/ that set `title` (writing/index.qmd uses `pagetitle`).
-- Schema: see docs/agent-posts.md.

local EVIDENCE_TYPES = { measured = true, experienced = true, cited = true, opinion = true }
local SOURCE_RELATIONS = { supports = true, contradicts = true, ["builds-on"] = true, background = true }

local MASTHEAD = [[
  <div class="masthead">
    <div class="masthead-row">
      <div>
        <h1 class="name">AJ WIEBE</h1>
        <div class="role">Software Engineer &middot; Principal Consultant</div>
      </div>
      <div class="theme-toggle">
        <button data-theme-btn="light" class="active">Light</button>
        <span class="sep">/</span>
        <button data-theme-btn="dark">Dark</button>
      </div>
    </div>
    <nav class="nav">
      <a href="/writing/" class="active">Writing</a>
      <a href="/projects/">Projects</a>
      <a href="/research.html">Research</a>
      <a href="/about.html">About</a>
    </nav>
  </div>
]]

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

local function str(v)
  if v == nil then return nil end
  local s = pandoc.utils.stringify(v)
  if s == "" then return nil end
  return s
end

-- Pandoc metadata (Inlines, Lists, maps) -> plain Lua values. Lists stay pandoc.List so the
-- encoder can tell arrays from objects, including empty ones.
local function plain(v)
  local t = pandoc.utils.type(v)
  if t == "Inlines" or t == "Blocks" or t == "Inline" or t == "Block" then
    return pandoc.utils.stringify(v)
  elseif t == "List" then
    local out = pandoc.List()
    for _, x in ipairs(v) do out:insert(plain(x)) end
    return out
  elseif type(v) == "table" then
    local out = {}
    for k, x in pairs(v) do out[k] = plain(x) end
    return out
  end
  return v
end

-- Escapes <, > and & as well, so the JSON can never close its <script> element.
local function quote(s)
  return '"' .. s:gsub('[%c"\\<>&]', function(c) return string.format("\\u%04x", c:byte()) end) .. '"'
end

local function encode(v)
  if v == nil then return "null" end
  if pandoc.utils.type(v) == "List" then
    local parts = {}
    for _, x in ipairs(v) do parts[#parts + 1] = encode(x) end
    return "[" .. table.concat(parts, ",") .. "]"
  end
  if type(v) == "table" then
    local keys = {}
    for k in pairs(v) do keys[#keys + 1] = tostring(k) end
    table.sort(keys)
    local parts = {}
    for _, k in ipairs(keys) do parts[#parts + 1] = quote(k) .. ":" .. encode(v[k]) end
    return "{" .. table.concat(parts, ",") .. "}"
  end
  if type(v) == "boolean" or type(v) == "number" then return tostring(v) end
  return quote(tostring(v))
end

local function list(v)
  if pandoc.utils.type(v) == "List" then return v end
  return pandoc.List()
end

-- Fails the render on malformed agent data instead of publishing tools that mislead agents.
local function validate(agent, file)
  local seen = {}
  for i, c in ipairs(list(agent.claims)) do
    local where = file .. ": agent.claims[" .. i .. "]"
    assert(type(c) == "table" and c.id and c.claim, where .. " needs `id` and `claim`")
    assert(not seen[c.id], where .. ": duplicate claim id `" .. c.id .. "`")
    seen[c.id] = true
    assert(type(c.evidence) == "table", where .. " needs `evidence`")
    assert(EVIDENCE_TYPES[c.evidence.type],
      where .. ".evidence.type must be measured, experienced, cited or opinion")
  end
  for i, s in ipairs(list(agent.sources)) do
    local where = file .. ": agent.sources[" .. i .. "]"
    assert(type(s) == "table" and s.url, where .. " needs `url`")
    assert(s.relation == nil or SOURCE_RELATIONS[s.relation],
      where .. ".relation must be supports, contradicts, builds-on or background")
  end
end

function Pandoc(doc)
  local file = quarto.doc.input_file or ""
  local meta = doc.meta
  if not file:match("[/\\]writing[/\\]") or not meta.title then return nil end

  local title = str(meta.title)
  local description = str(meta.description)
  local published = str(meta.date)
  local updated = str(meta["date-modified"])
  local agent = meta.agent and plain(meta.agent) or {}
  assert(type(agent) == "table" and pandoc.utils.type(agent) ~= "List", file .. ": `agent` must be a map")
  validate(agent, file)

  local outline = pandoc.List()
  doc.blocks = doc.blocks:walk({
    Header = function(h)
      if h.level ~= 2 then return nil end
      h.classes:insert("h2") -- matches the hand-written pages and the get_current_page parser
      outline:insert({ heading = pandoc.utils.stringify(h.content), anchor = "#" .. h.identifier })
      return h
    end,
  })

  local data = {
    title = title,
    description = description,
    published = published,
    updated = updated,
    author = str(meta.author) or "AJ Wiebe",
    outline = outline,
    agent = agent,
  }

  local head = MASTHEAD
    .. '  <div class="crumb"><a href="/writing/">Writing</a> / ' .. esc(title) .. "</div>\n"
    .. '  <h1 class="title">' .. esc(title) .. "</h1>\n"
  if description then head = head .. '  <p class="dek">' .. esc(description) .. "</p>\n" end
  if published then
    local dates = "Published " .. esc(published)
    if updated and updated ~= published then dates = dates .. " &middot; Updated " .. esc(updated) end
    head = head .. '  <p class="muted post-dates">' .. dates .. "</p>\n"
  end

  local body = pandoc.List({ pandoc.RawBlock("html", head) })
  body:extend(doc.blocks)
  body:insert(pandoc.RawBlock("html",
    '<script type="application/json" id="post-agent">' .. encode(data) .. "</script>"))
  doc.blocks = pandoc.Blocks({ pandoc.Div(body, pandoc.Attr("", { "wrap" })) })
  return doc
end
