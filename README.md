# shiftlefter.com

This repository is the live [shiftlefter.com](https://shiftlefter.com) site,
served by GitHub Pages (native Jekyll build). **Merging to `main` deploys the
live site** — `main` is branch-protected (PR required, admins included), so
publishing is always a deliberate merge.

The site is a pointer; the [shiftlefter repository](https://github.com/shift-lefter/shiftlefter)
owns the product content. `/report/` hosts a sample HTML run report —
see `report/README-REGEN.md` for how it is regenerated.

## JavaScript on this site

Exactly two scripts, both in `_layouts/default.html`, both optional to the
reading experience:

- **GoatCounter** — the one analytics tag (sl-8yfe).
- **The theme toggle** (sl-cvow) — a few inline lines: the system
  light/dark preference is the default, the sun/moon button in the nav
  stores an override in `localStorage`, and a head snippet applies it
  before first paint. No framework, no bundle, no third-party host.

Everything else — including the mermaid diagrams under `/docs/`, which are
baked to SVG at sync time — is static. Adding a third script is a decision,
not a drift; update this list when it happens.

## The namespace rule

- **`/writing/*` is the Jekyll posts surface** — posts, the writing index, feed.
- **Every other root path is free static content.** Files without front
  matter pass through the build byte-identical (the marketing front page,
  `llms.txt`, `/report/*`, and anything else parked here). Convenience
  plugins that would convert loose `.md` files into pages are disabled in
  `_config.yml` — a dropped directory serves exactly as dropped.

## Publishing a post

1. Write `_posts/YYYY-MM-DD-slug.md` with front matter:

   ```yaml
   ---
   title: "Post title"
   date: YYYY-MM-DD HH:MM:SS -0500
   ---
   ```

2. Chapter anchors are **explicit only** — `## Heading {#frozen-id}`.
   Auto-generated IDs are off; an anchor exists exactly when one was
   deliberately frozen onto a heading, because published anchors are
   permanent deep-link targets.
3. Preview locally (below), push the branch to the `github` remote, open a
   PR there, merge it. **The merge commit is the publication timestamp.**

Remote topology: `origin` (gl.3var.com) is the working remote — all branches
live there and nothing deploys from it. The `github` remote deploys `main`
via GH Pages and receives branches only when a publish PR is being opened.

The post URL becomes `shiftlefter.com/writing/YYYY/MM/slug/` — this permalink
scheme is the frozen citation contract (see the header of `_config.yml`);
published URLs and anchors never change. Drafts in `_drafts/` never build on
GitHub Pages (`--drafts` previews them locally).

## Local preview

```bash
bundle install          # once; needs Ruby 3.3 (brew install ruby@3.3)
bundle exec jekyll serve --drafts   # http://127.0.0.1:4000
```

## CSS variable contract

`assets/css/writing.css` defines the theme tokens (`--sl-bg`, `--sl-fg`,
`--sl-muted`, `--sl-accent`, `--sl-rule`) with light/dark values via
`prefers-color-scheme`. The token **names** are load-bearing: the theme
restyles by changing values, and embedded SVGs (the map one-pager) inherit
them by name. Rename nothing.
