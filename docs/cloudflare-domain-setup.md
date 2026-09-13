# Pointing systemsbyaj.com at this site (Cloudflare)

For AJ to do later — nothing here is executed by the build, and this
doc is not linked from the public site (it's an operational runbook,
not part of "how the site was built").

## Where things stand right now

- The repo has a `CNAME` file at its root containing `systemsbyaj.com`.
  Quarto automatically copies this into `_site/` on render, so it ends
  up in the published output — confirmed by checking a local build.
- `.github/workflows/publish.yml` renders the site and pushes `_site/`
  content to the `gh-pages` branch on every push to `main`. GitHub
  Pages is already enabled and serving from that branch (confirmed).
- Nothing below is done yet: no DNS records exist for
  `systemsbyaj.com`, and GitHub Pages hasn't been told about the custom
  domain outside of the `CNAME` file already being present in the
  deployed output.

## Outstanding — what's left to do

Nothing in "The plan" below has been started. In order:

- [ ] Add `systemsbyaj.com` as a site in Cloudflare; note the two
      nameservers it assigns.
- [ ] At the domain registrar, point `systemsbyaj.com`'s nameservers at
      those two Cloudflare nameservers. (Propagation: up to a few
      hours.)
- [ ] In Cloudflare DNS, add the four apex `A` records for
      `systemsbyaj.com` → `185.199.108.153`, `185.199.109.153`,
      `185.199.110.153`, `185.199.111.153`.
- [ ] In Cloudflare DNS, add the `www` `CNAME` record →
      `alexanderwiebe.github.io`.
- [ ] Set all five of those records to **DNS only** (grey cloud, not
      proxied).
- [ ] In the GitHub repo Settings → Pages, confirm `systemsbyaj.com`
      shows as the custom domain.
- [ ] Once available, check "Enforce HTTPS" in Settings → Pages
      (GitHub needs up to ~24h after DNS propagates to issue the
      certificate).

## The goal

Keep GitHub Pages as the host — no second build pipeline — with
`systemsbyaj.com` as the domain people actually see. Once a `CNAME`
file is present in the published output and GitHub detects
`systemsbyaj.com` as the repo's custom domain, GitHub Pages
**automatically redirects** requests for `alexanderwiebe.github.io` to
`systemsbyaj.com`. That's not a misconfiguration to work around — it's
exactly what "one canonical site, old `.github.io` links still
resolve" requires, and it's the outcome wanted here.

(The alternative — both domains independently serving content, with no
redirect — would need a second, separate hosting target for
`systemsbyaj.com`, e.g. Cloudflare Pages, running in parallel with
GitHub's build. That's more infrastructure for no benefit here, so it's
not the plan; see "Alternative not chosen" below if that ever changes.)

## The plan — Cloudflare as DNS only, accept the redirect

1. In Cloudflare, add `systemsbyaj.com` as a site (Cloudflare will scan
   existing DNS, then give you two nameservers).
2. At your domain registrar, change `systemsbyaj.com`'s nameservers to
   the two Cloudflare gave you. (This step is at the registrar, not in
   Cloudflare — propagation can take a few hours.)
3. In Cloudflare's DNS tab, add:
   - Four `A` records for the apex (`systemsbyaj.com`) pointing to
     GitHub Pages' IPs: `185.199.108.153`, `185.199.109.153`,
     `185.199.110.153`, `185.199.111.153`.
   - One `CNAME` record for `www` pointing to `alexanderwiebe.github.io`.
   - Set every one of these records to **DNS only** (grey cloud, not
     proxied/orange) — GitHub Pages needs to see the real request to
     issue its own TLS certificate for the domain; Cloudflare's proxy
     in front of that will break GitHub's certificate validation on
     first setup. (You can turn proxying on later, after the cert is
     issued, if you want Cloudflare's CDN/caching — not required.)
4. In the GitHub repo's Settings → Pages, confirm the custom domain
   shows `systemsbyaj.com` (it should auto-populate from the `CNAME`
   file once DNS resolves) and check "Enforce HTTPS" once the option
   is available (GitHub needs to issue a certificate first, which can
   take up to ~24h after DNS propagates).
5. Done. `systemsbyaj.com` is canonical; `alexanderwiebe.github.io`
   redirects to it automatically. This is 15 minutes of DNS records and
   a checkbox — no second build pipeline to babysit.

## Alternative not chosen — Cloudflare Pages as a second, independent host

Recorded for reference in case the goal changes later (e.g. wanting
`alexanderwiebe.github.io` to keep serving content instead of
redirecting). This would keep `alexanderwiebe.github.io` serving on its
own, with `systemsbyaj.com` served entirely by Cloudflare Pages instead
of GitHub Pages — a second, independent deploy pipeline running
alongside GitHub's, for a payoff (both domains truly live, no redirect)
that only matters if the `.github.io` link is already circulating
somewhere.

1. **Remove `CNAME` from the repo** (or at minimum, make sure GitHub
   Pages' Settings → Pages does *not* have a custom domain configured).
   As long as GitHub Pages doesn't know about `systemsbyaj.com`, it has
   no reason to redirect.
2. In Cloudflare, create a **Pages** project (not just a DNS zone) and
   connect it to this GitHub repo, same branch (`main`).
   - Build command: `quarto render`
   - Output directory: `_site`
   - Cloudflare Pages needs Quarto available in its build image — check
     whether Cloudflare's build environment has it, or add a build step
     that installs it (a `package.json` postinstall script, or check
     Cloudflare Pages' custom build image options). This is the one
     step likely to need iteration; the render itself is a plain
     `quarto render` with no other dependencies.
3. In Cloudflare Pages' custom domains settings, add `systemsbyaj.com`
   (and `www.systemsbyaj.com` if wanted) directly — Cloudflare issues
   its own certificate and wires the DNS automatically since the domain
   is already on Cloudflare.
4. Result: `systemsbyaj.com` → Cloudflare Pages, `alexanderwiebe.github.io`
   → GitHub Pages, both live, both serving the same content from
   independent builds of the same repo.
5. Would need a `rel="canonical"` strategy for SEO — two indexable
   domains with identical content can dilute search ranking unless one
   declares itself canonical.
