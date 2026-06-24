# al-folio Features Checklist

Track which features of the al-folio template are actively used on this site.

## Core Pages & Content

- [x] **About/Home Page** — Landing page with bio, profile picture, and social links
- [ ] **Blog** — Blog posts with tags, categories, and pagination
- [ ] **Publications** — Bibliography-driven publications page with badges and filtering
- [ ] **Projects** — Portfolio cards with categories and descriptions
- [ ] **CV** — Curriculum vitae (RenderCV YAML or JSON Resume format)
- [ ] **Teaching** — Courses and teaching materials
- [ ] **News/Announcements** — News items and announcements sidebar
- [ ] **Books** — Book collection/review page
- [ ] **Repositories** — GitHub profile stats and pinned repos

## Content Features

- [x] **Social Icons** — GitHub, LinkedIn, Google Scholar, email
- [x] **Profile Picture** — Circular profile image
- [ ] **Selected Papers** — Highlighted/featured publications
- [ ] **Latest Blog Posts** — Sidebar with newest posts
- [ ] **External Blog Posts** — RSS feed integration (Medium, etc.)

## Interactive Features

- [ ] **Search** — Full-text search with Cmd-K palette (ninja-keys)
- [ ] **Comments** — Giscus or Disqus discussion threads on posts
- [ ] **Comments Moderation** — Admin approval for comments
- [ ] **Newsletter Signup** — Loops.so email signup form
- [ ] **Dark Mode Toggle** — Light/dark theme switcher
- [ ] **Tooltips** — Auto-generated section tooltips

## Media & Visualization

- [x] **Responsive Images** — WebP conversion and lazy loading
- [ ] **Image Zoom** — Medium.com-style image lightbox
- [ ] **Image Galleries** — Grouped image displays
- [ ] **Math Typesetting** — MathJax for LaTeX equations
- [ ] **Code Highlighting** — Syntax highlighting with Rouge
- [ ] **Diagrams** — Mermaid, PlantUML, or other diagram support
- [ ] **Charts** — Chart.js, Plotly, Vega, ECharts, Leaflet maps
- [ ] **TikZ Diagrams** — TikZJax for rendering TikZ code
- [ ] **Jupyter Notebooks** — Embedded notebook rendering

## SEO & Metadata

- [ ] **Open Graph Tags** — Social media preview cards
- [ ] **Schema.org Markup** — Structured data for search engines
- [ ] **Google Analytics** — Google Analytics tracking
- [ ] **Google Search Console** — Site verification
- [ ] **Bing Webmaster Tools** — Bing site verification
- [ ] **Sitemap** — XML sitemap generation
- [ ] **RSS Feed** — Blog RSS feed

## Analytics & Monitoring

- [ ] **Google Analytics** — Traffic analytics
- [ ] **Cronitor RUM** — Real User Monitoring
- [ ] **Pirsch Analytics** — Privacy-focused analytics
- [ ] **OpenPanel** — Event tracking

## Academic Features

- [ ] **Publication Badges** — Altmetric, Dimensions, Google Scholar, Inspire HEP citations
- [ ] **Bibliography Management** — Bibtex parsing and APA formatting
- [ ] **Author Name Variants** — Handle name variations (e.g., first name/initials)
- [ ] **Max Author Limit** — Expand author lists on click
- [ ] **Publication Thumbnails** — Preview images for papers

## Integrations

- [ ] **Docker Support** — Containerized local development
- [ ] **GitHub Actions CI/CD** — Automated testing and deployment
- [ ] **Pre-commit Hooks** — Linting before commits
- [ ] **Prettier Formatting** — Code style enforcement
- [ ] **Visual Regression Tests** — Playwright screenshot comparisons
- [ ] **Lighthouse Performance** — Performance monitoring

## Design & Customization

- [x] **Fixed Navbar** — Sticky navigation bar
- [x] **Fixed Footer** — Sticky footer
- [ ] **Project Masonry Layout** — Auto-arrange project cards
- [ ] **Project Categories** — Filter projects by category
- [ ] **Progress Bar** — Scroll progress indicator
- [ ] **GDPR Cookie Consent** — Cookie banner and consent management
- [ ] **Tailwind CSS** — Utility-first styling (v1.x)
- [ ] **Responsive Design** — Mobile-first layout
- [ ] **Theme Customization** — Light/dark mode colors

## Performance & Build

- [ ] **CSS Purging** — Remove unused CSS (PurgeCSS)
- [ ] **JavaScript Minification** — Terser minification
- [ ] **Image Optimization** — ImageMagick WebP conversion
- [ ] **Asset Versioning** — Cache busting for assets
- [ ] **Incremental Jekyll Build** — Fast rebuilds

## Bootstrap Compatibility (v1.0-v1.2, deprecated)

- [ ] **Bootstrap CSS/JS** — Bootstrap v4 compatibility layer (time-limited support)

---

**Last Updated:** 2026-06-24

**Active Features:** About page, social links, responsive images, fixed navbar/footer

**Notes:** 
- Most specialized academic features (publications, CV, teaching) are available but not yet configured
- Security scanning (CodeQL) and testing workflows can be disabled if not needed
- Focus first on expanding Blog and Projects sections if planning multi-section site
