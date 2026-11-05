// Checks a rendered site (_site) for what the WebMCP tools need. Run by CI after `quarto render`.
import fs from "node:fs";
import assert from "node:assert/strict";

const read = (p) => fs.readFileSync(`_site/${p}`, "utf8");
const DATA_RE = /<script type="application\/json" id="webmcp-data">([\s\S]*?)<\/script>/;
const data = (p) => JSON.parse(read(p).match(DATA_RE)[1]);

for (const page of ["index.html", "about.html", "resume.html", "research.html", "projects/index.html", "writing/index.html"]) {
  const html = read(page);
  assert.match(html, DATA_RE, `${page}: webmcp data`);
  assert.match(html, /webmcp\.js/, `${page}: extension runtime`);
  assert.match(html, /addSiteTools/, `${page}: site-tools.html`);
  assert.equal((html.match(/http-equiv="origin-trial"/g) || []).length, 2, `${page}: origin-trial tokens`);
}

const site = data("index.html").site;
assert.equal(site.posts, "writing");
assert.equal(site.content.root, ".wrap");
assert.equal(site.theme.light, "[data-theme-btn=light]", "theme selector survives metadata parsing");

const post = data("writing/using-webmcp/index.html");
assert.equal(post.page.kind, "post");
assert.ok(post.page.agent.claims.length > 0, "post agent data");
assert.equal(data("writing/index.html").page.kind, "page", "the listing is not a post");

const index = JSON.parse(read("webmcp-index.json"));
const paths = index.pages.map((p) => p.path);
for (const p of ["./", "about.html", "resume.html", "research.html", "projects/", "writing/using-webmcp/", "writing/answerable-posts/"]) {
  assert.ok(paths.includes(p), `index has ${p}`);
}
assert.match(read("llms.txt"), /^# AJ Wiebe/, "the hand-written llms.txt is kept");

console.log(`ok: ${index.pages.length} pages indexed`);
