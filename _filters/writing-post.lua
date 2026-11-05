-- Turns a Markdown post under writing/ into a site page: wraps it in the site chrome (masthead,
-- crumb, title, dek, dates) so posts can be plain Markdown instead of hand-written HTML like the
-- other pages, and gives second-level headings the site's h2 class.
--
-- The post's `agent:` frontmatter and WebMCP tools come from the quarto-webmcp extension
-- (_extensions/alexanderwiebe/webmcp), which also validates it. See docs/agent-posts.md.
--
-- Acts only on documents under writing/ that set `title` (writing/index.qmd uses `pagetitle`).

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

function Pandoc(doc)
  local file = quarto.doc.input_file or ""
  local meta = doc.meta
  if not file:match("[/\\]writing[/\\]") or not meta.title then return nil end

  local title = str(meta.title)
  local description = str(meta.description)
  local published = str(meta.date)
  local updated = str(meta["date-modified"])
  assert(title, file .. ": a post needs a title")

  doc.blocks = doc.blocks:walk({
    Header = function(h)
      if h.level ~= 2 then return nil end
      h.classes:insert("h2") -- matches the hand-written pages and the webmcp.content.heading selector
      return h
    end,
  })

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
  doc.blocks = pandoc.Blocks({ pandoc.Div(body, pandoc.Attr("", { "wrap" })) })
  return doc
end
