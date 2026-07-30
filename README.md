# rupeshprasad.com

Personal website for **Rupesh Prasad** — Technical Architect & Senior Manager at Analog Devices, IEEE Senior Member, and Raptors.dev Fellow.

Multi-page [Jekyll](https://jekyllrb.com/) site hosted on GitHub Pages at [rupeshprasad.com](https://rupeshprasad.com). GitHub Pages builds it automatically on push — no local build required.

## Structure

| File | Purpose |
|------|---------|
| `index.html` | Home / About |
| `experience.html` | Experience & Education (`/experience/`) |
| `research.html` | Research, speaking, judging, publications & contributions (`/research/`) |
| `skills.html` | Skills, Certifications, Honors & Languages (`/skills/`) |
| `contact.html` | Contact (`/contact/`) |
| `_layouts/default.html` | Page shell shared by every page |
| `_includes/head.html` | `<head>` (title/description from each page's front matter) |
| `_includes/nav.html` | Top navigation (active tab via `nav:` front matter) |
| `_includes/footer.html` | Footer (year set at runtime) |
| `_config.yml` | Jekyll config |
| `assets/style.css` | Shared stylesheet |
| `assets/*.jpg` | Images (e.g. conference poster) |

The header, nav, and footer live once in `_includes` / `_layouts`; each page file holds only its own content plus front matter.

## Local preview (optional)

```bash
bundle exec jekyll serve   # requires Ruby + the github-pages gem
```

Otherwise just push to `main` and GitHub Pages will build and publish.
