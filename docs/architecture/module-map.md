---
layout: doc
title: "Module Map"
subtitle: "checked against the actual require graph (2026-08-18; re-extracted 2026-08-26)"
kind: Architecture
permalink: /docs/architecture/module-map/
source: docs/architecture/module-map.md
source_url: https://github.com/shift-lefter/shiftlefter/blob/main/docs/architecture/module-map.md
synced_from: b575d948
---
{% raw %}

Arrows below are EXTRACTED from `(:require …)` forms across
`src/shiftlefter/**/*.clj` (525 rows at the 2026-08-26 re-extraction), not
drawn from memory. Raw edge list: regenerate with the one-liner in
§ Method.


{: id="the-intended-shape-the-laws-as-practiced"}
## The intended shape (the laws as practiced)

<figure class="diagram">
  <img class="diagram-light" src="/assets/docs/architecture-module-map-0-light.svg" alt="diagram">
  <img class="diagram-dark" src="/assets/docs/architecture-module-map-0-dark.svg" alt="diagram">
</figure>

Laws checked: (1) etaoin contained to the webdriver layer; (2) svo never
reaches up into stepengine/runner — EXCEPT engine-owned
vocabulary/grammar definitions; (3) gherkin is a leaf;
(4) stepengine never reaches up into runner — passes unrestated since
the config extraction (2026-08-26): the config-accessor exception
dissolved when `runner.config` moved to the neutral `shiftlefter.config`
address, so the one
formerly-excepted edge now points down into substrate. The dotted
SVO→CONFIG arrow is the language layer consuming ONLY the cluster's
`shiftlefter.text` did-you-mean substrate (`svo/{validate,bindings_lint}
→ text`); no svo namespace requires `shiftlefter.config` itself — the
raw-token row `svo/validate → shiftlefter.config` in the edge list is a
docstring mention, not a require.


{: id="verdict"}
## Verdict

**Sane.** No dependency cycles (the Clojure loader would refuse them), the
hub shape is as intended (invocation surfaces fan into runner; runner
orchestrates the engine; the engine consumes the language layer), gherkin
is a clean leaf (law 3 passes with zero violations).


{: id="method"}
## Method

```bash
for f in $(find src/shiftlefter -name "*.clj"); do
  ns=$(basename $f .clj); dir=$(dirname $f | sed 's|src/shiftlefter/*||')
  grep -o "shiftlefter\.[a-z0-9.-]*" $f | sort -u | sed "s|^|${dir:-ROOT}/$ns -> |"
done
```

Cluster-level aggregate: `awk` the first path segment of each side, count
distinct arrows. Re-run after any relocation to verify the arrows moved.


{: id="how-this-map-stays-true"}
## How this map stays true

This page is a mechanical projection of a live-maintained internal map:
re-verified against the code by probe runs at each re-stamp, regenerated —
never hand-edited — by the derivation pipeline, and drift-guarded by the
test suite (a hand edit here fails a test). File:line pins are re-verified
at each re-stamp.
{% endraw %}
