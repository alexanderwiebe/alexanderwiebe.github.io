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

## The constraint that shapes both options

Once a `CNAME` file is present in the published output and GitHub
detects `systemsbyaj.com` as the repo's custom domain, GitHub Pages
**automatically redirects** requests for `alexanderwiebe.github.io` to
`systemsbyaj.com`. There is no setting to keep both simultaneously live
through one Pages deployment — this is standard GitHub behavior, not a
misconfiguration to fix.

That means "both domains live" has two genuinely different meanings,
and they need different setups:

- **A. One canonical site, old links still resolve.** `systemsbyaj.com`
  is the real site; `alexanderwiebe.github.io` forwards to it. Simple,
  standard, no SEO downside (search engines follow the redirect and
  index one URL).
- **B. Both domains independently serve content, no redirect.** Needs a
  second, separate hosting target for `systemsbyaj.com` — Cloudflare
  Pages, in this case — so GitHub Pages never learns about the custom
  domain and keeps serving `alexanderwiebe.github.io` untouched.

Pick one before starting; the setup steps diverge immediately.

## Option A — Cloudflare as DNS only, accept the redirect

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
   redirects to it automatically.

## Option B — Cloudflare Pages as a second, independent host

This keeps `alexanderwiebe.github.io` serving on its own, with
`systemsbyaj.com` served entirely by Cloudflare Pages instead of GitHub
Pages. GitHub never learns about the custom domain, so no redirect
happens.

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
5. Add a `rel="canonical"` strategy if this bothers you for SEO — two
   indexable domains with identical content can dilute search ranking
   unless one declares itself canonical. That partially undercuts "both
   fully live" as a goal, so decide if it matters before setting it up;
   if it does, canonical tags would point at `systemsbyaj.com` from
   both deployments, and `alexanderwiebe.github.io` stays reachable but
   not preferred by search engines — still genuinely live for anyone
   with the link, just not the one Google shows.

## Recommendation, non-binding

Option A is a few DNS records and a checkbox — 15 minutes, no build
pipeline to babysit. Option B is a second, independent deploy pipeline
you now maintain in parallel with GitHub's, for a payoff (both domains
truly live) that mostly matters if the `.github.io` link is already
circulating somewhere and you don't want it to redirect. Worth checking
whether that's actually true before building the second pipeline.
