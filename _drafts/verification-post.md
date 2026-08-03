---
title: "Verification post (never publishes)"
date: 2026-08-03 10:00:00 -0500
---

This post exercises the blog mechanics (sl-5dhn). It lives in `_drafts/`
after verification, so GitHub Pages never builds it — the live blog index
stays empty until publication event 1 (sl-vvxu).

## A frozen chapter anchor {#frozen-anchor-one}

This heading carries an explicit kramdown ID. Spoke posts deep-link to
anchors like this one; the ID never derives from the title.

## A heading with no anchor

With `auto_ids` disabled, this heading must render with **no** `id`
attribute at all — an anchor exists exactly when one was deliberately
frozen onto a heading.

### Code block check {#frozen-anchor-two}

```clojure
(defn hello [] :world)
```

Inline `code`, a [link](https://shiftlefter.com), and an em-dash — done.
