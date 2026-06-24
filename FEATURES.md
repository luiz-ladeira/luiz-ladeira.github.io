# al-folio Features Checklist

A snapshot of every feature in this site and its **current state**.

- `[x]` = enabled / configured with your content
- `[ ]` = available but disabled, or still holding example content

> ⚠️ **BLOCKER — unresolved merge conflicts committed.** `_config.yml` and
> `_pages/about.md` currently contain literal `<<<<<<< HEAD` / `=======` /
> `>>>>>>>` conflict markers (committed in the `update` / `a` commits). The
> Jekyll build **will fail** until these are resolved. This file documents the
> repo as-is; nothing was modified per your request.

> **Version:** This is al-folio **v0.x** (classic) — the runtime lives **locally**
> in `_layouts/`, `_includes/`, `_sass/`, `_plugins/` (you own and can edit it
> directly). Social links use flat `*_username` keys in `_config.yml`.
> Custom additions beyond stock al-folio: `map/app.R` (R/Shiny), `reports/`,
> `news.html`, `bio.md`, `header-backup.html`.

---

## Pages (`_pages/`)

| Page | State | Notes |
| --- | --- | --- |
| About / Home (`about.md`) | [x] | **Your bio** (⚠️ has conflict markers) |
| Bio (`bio.md`) | [ ] | Extra bio page |
| Projects (`projects.md`) | [ ] | Example projects in `_projects/` |
| Publications (`publications.md`) | [ ] | Example `papers.bib` |
| CV (`cv.md`) | [ ] | Driven by `_data/cv.yml` / `resume.json` |
| Teaching (`teaching.md`) | [ ] | Example content |
| News (`news.md` / `news.html`) | [ ] | Example news items |
| Repositories (`repositories.md`) | [ ] | GitHub stats/repos |
| Profiles (`profiles.md`) | [ ] | Multi-profile people page |
| Dropdown (`dropdown.md`) | [ ] | Example navbar dropdown |
| about_einstein | [ ] | Demo page |
| 404 (`404.html`) | [x] | Error page |
| Blog | [ ] | `blog/` dir + `blog_name: ladeira`; example posts in `_posts/` |

## Layout & Navigation

| Feature | State |
| --- | --- |
| Fixed navbar | [x] `navbar_fixed: true` |
| Fixed footer | [x] `footer_fixed: true` |
| Dark mode toggle | [x] `enable_darkmode: true` |
| Max width 1000px | [x] |
| Social links in navbar | [ ] `enable_navbar_social: false` |
| Section tooltips | [ ] `enable_tooltips: false` |
| Scroll progress bar | [ ] `enable_progressbar: false` |

## Social & Contact (flat keys in `_config.yml`)

| Link | State |
| --- | --- |
| GitHub | [x] luiz-ladeira |
| LinkedIn | [x] luizladeira |
| Google Scholar | [x] 8pFoo94AAAAJ |
| Lattes | [x] 6144420994544611 |
| RSS icon | [ ] `rss_icon: false` |
| ORCID, Twitter, Mastodon, ResearchGate, Scopus, etc. | [ ] empty templates |

## Content / Profile Components (`_includes/`)

| Feature | State |
| --- | --- |
| Social icons block (`social.html`) | [x] `social: true` on about |
| Profile picture | [x] `prof_pic.png`, circular |
| News on about page | [ ] `news: false` |
| Latest posts on about page | [ ] `latest_posts: false` |
| Selected papers on about page | [ ] `selected_papers: false` |
| Figure / audio / video includes | [ ] available |
| Related posts | [ ] available |

## Media & Visualization

| Feature | State | Plugin |
| --- | --- | --- |
| Responsive WebP images | [x] `imagemagick.enabled: true` | jekyll-imagemagick |
| Image zoom (medium-style) | [x] `enable_medium_zoom: true` | medium-zoom |
| Project masonry layout | [x] `enable_masonry: true` | masonry |
| Math typesetting (MathJax) | [x] `enable_math: true` | MathJax |
| Diagrams (Mermaid/PlantUML/etc.) | [ ] plugin present, unused | jekyll-diagrams |
| Jupyter notebooks | [ ] plugin present, unused | jekyll-jupyter-notebook |
| Twitter embeds | [ ] plugin present, unused | jekyll-twitter-plugin |
| Table of contents | [ ] plugin present | jekyll-toc |

## Academic / Publications (`jekyll/scholar`)

| Feature | State |
| --- | --- |
| Bibliography (BibTeX → APA) | [ ] Example `papers.bib`; scholar name set to "Ladeira" |
| Publication thumbnails | [x] `enable_publication_thumbnails: true` |
| Altmetric badge | [x] enabled |
| Dimensions badge | [x] enabled |
| Author name variants | [x] configured (Ladeira / Maia Ladeira / M. L.) |

## Blog (`jekyll-archives` + `jekyll-paginate-v2`)

| Feature | State |
| --- | --- |
| Pagination | [x] `pagination.enabled: true` |
| Related posts | [x] `related_blog_posts.enabled: true` |
| Year / tag / category archives | [x] `jekyll-archives` |
| Example posts | [ ] still al-folio demo posts in `_posts/` |

## Comments & Engagement

| Feature | State |
| --- | --- |
| Giscus comments | [ ] `giscus.repo` empty (not configured) |
| Disqus comments | [ ] default `al-folio` shortname (not yours) |

## Analytics & SEO

| Feature | State |
| --- | --- |
| Google Analytics | [x] `enable_google_analytics: true` → `G-EVN0SL22KD` ⚠️ from old site |
| Cronitor RUM | [ ] `enable_cronitor_analytics: false` |
| Sitemap | [x] jekyll-sitemap (auto) |
| RSS feed | [x] jekyll-feed (auto) |
| Open Graph tags | [ ] `serve_og_meta: false` |
| Schema.org markup | [ ] `serve_schema_org: false` |
| Google Search Console | [ ] `enable_google_verification: false` |
| Bing verification | [ ] `enable_bing_verification: false` |

## Projects

| Feature | State |
| --- | --- |
| Project cards | [ ] 9 example projects in `_projects/` |
| Project categories filter | [ ] `enable_project_categories: false` |
| Horizontal project layout | [ ] include available |

## Custom Additions (non-stock)

| Item | State | Notes |
| --- | --- | --- |
| `map/app.R` | [x] present | R/Shiny app (not served by Jekyll) |
| `reports/` | [x] present | PageSpeed/Lighthouse SVGs |
| `news.html` | [x] present | Root-level news page |
| `bio.md` | [x] present | Secondary bio page |

## Build & Tooling

| Feature | State |
| --- | --- |
| GitHub Pages deploy | [x] `.github/workflows/deploy.yml` |
| `.nojekyll` | [x] present |
| CSS purging (PurgeCSS) | [x] `purgecss.config.js` |
| JS/CSS minification | [x] jekyll-minifier |
| Docker dev environment | [x] `docker-compose.yml` |
| Email obfuscation | [x] jekyll-email-protect |
| External link attributes | [x] jekyll-link-attributes |

---

**Last analyzed:** 2026-06-24 (after reset to previous v0.x version)

**Immediate action needed:** Resolve the merge-conflict markers in
`_config.yml` and `_pages/about.md` — the build is broken until then.

**Currently *your* content:** About/bio + social links + Google Analytics.
Projects, publications, CV, teaching, news still show al-folio example content.
