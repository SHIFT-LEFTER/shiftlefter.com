---
layout: doc
title: "The Invocation Map"
subtitle: "every `sl` verb through the shared spine"
kind: Architecture
permalink: /docs/architecture/invocation-map/
source: docs/architecture/invocation-map.md
source_url: https://github.com/shift-lefter/shiftlefter/blob/main/docs/architecture/invocation-map.md
synced_from: b575d948
---
{% raw %}

Extracted and live-verified against the code of the v0.5.5 release line
(2026-08-18); line pins re-verified and the `init` lane added 2026-08-23.
Every exit code below was transcribed from an actual run. Verb
completeness comes from the dispatch table itself, not from
memory.


{: id="the-shape-in-one-paragraph"}
## The shape in one paragraph

There is **one command entry point**: `dispatch` (`src/shiftlefter/core.clj:887`)
returns an exit code and never calls `System/exit`, so the cold CLI
(`-main`, `core.clj:1032`) and the warm daemon (`daemon.clj:339
dispatch!`) run the *same* branches — warm/cold parity is structural, not
tested-in. Verbs then split into three families: the **run family**
walks the runner pipeline's stages and speaks the verdict contract; the
**query family** (`orient`, `glossary`, `explain`) rides
`build-projection` (`project_projection.clj:571`) — the run's own
config/glossary/intent/stepdef loaders behind one resolver, so a listing
can never disagree with the run it predicts — and since resolution
queries v2, `glossary`/`explain` additionally re-enter
discover→parse→compile through `projection/usage_index.clj` to bind the corpus
for usage facts (same binder, never a parallel path); the **utility
family** (`fmt`, `doctor`, `costume`, `daemon`, `agent-doc`,
`gherkin`, `verify`) needs at most the project context.


{: id="the-spine"}
## The spine

<figure class="diagram">
  <img class="diagram-light" src="/assets/docs/architecture-invocation-map-0-light.svg" alt="diagram">
  <img class="diagram-dark" src="/assets/docs/architecture-invocation-map-0-dark.svg" alt="diagram">
</figure>

Two facts the diagram earns its place by showing: **the planning verbs
stop at compile** (dry-run's exit 0 is a plan verdict — the selection
binds — not a run verdict), and **the query surfaces hang off the same
resolver the run uses**, with the v2 usage loop drawn as a re-entry into
the run's own discovery/parse/bind stages rather than a second reader.


{: id="lanes"}
## Lanes

Every branch of the dispatch `cond` (`core.clj:917-1030`), one row each.
"Enters at" is the branch's command fn; codes marked ✓ were produced by a
live run.

| Verb | Enters at | Stops at | Emits | Exit codes (live-verified ✓) |
|---|---|---|---|---|
| `run` | `run-cmd` core.clj:132 → `execute!` runner/core.clj:1891 | full pipeline → verdict | console report; `--edn` summary; `--junit-xml`; `--html`; captures | 0 pass ✓ · 1 fail ✓ · 2 planning/bad path ✓ · 3 crash · 4 degraded (the verdict table below) |
| `run --dry-run` | same | after compile-suite + capture-plan lint (runner/core.clj:2063) | bound-plan line (stderr), hook preview; `--edn` plan summary | 0 binds ✓ · 2 binding/discovery errors ✓ |
| `fmt` (`--check/--write/--canonical`) | `fmt-cmd` core.clj:433 | parser round-trip only — no pickles, no binding | per-file OK/NOT-OK lines; formatted text | 0 clean ✓ · 1 check-failure ✓ · 2 usage. NOTE: fmt's 1 is "file not canonical", not the verdict table's "scenario failed" — fmt is not a run surface |
| `gherkin fuzz` | `fuzz-cmd` core.clj:539 | parser property loop (no project context use) | trial summary; failure artifacts under `--save` | 0 all pass ✓ · 1 failures. Framework-dev tool |
| `gherkin ddmin` | `ddmin-cmd` core.clj:597 | parser shrink loop | minimized `<file>.min` | 0 wrote minimal ✓ · 2 no path. Framework-dev tool |
| `verify` | `verify-cmd` core.clj:673 | validator battery (framework repo only) | check report | 0 · 1 failures · 2 outside framework repo ✓ |
| `agent-doc` | `agent_doc.clj:98` | resource print (no project context — the one context-free verb, core.clj:912) | packaged doctrine topic | 0 ✓ |
| `orient` | `orient.clj:178` | projection (no corpus bind) | orientation card; `--edn` full projection | 0 ✓ · 1 projection load failure · 2 ambiguous config |
| `glossary` | `resolution.clj:531` | projection + corpus bind (usage markers; `duplicates` section skips the corpus) | listing with provenance + usage markers; `--edn` | 0 listed/honest-vanilla/no-project ✓ · 1 load failure · 2 bad section/ambiguous config |
| `explain` | `resolution.clj:943` | projection + corpus bind; `{…}` arg → locator reverse index only | per-kind resolution + usage; owners for a locator | 0 found ✓ · 1 miss ✓ · 2 malformed ✓ |
| `costume init` | core.clj:719 | wardrobe + real Chrome launch | profile dir + live browser for one-time login | 0 · 1 launch failure · 2 usage (code-read; not live-run — launches a real browser) |
| `costume relaunch` | core.clj:733 | wardrobe + Chrome relaunch | relaunched browser on the costume profile | as init (code-read) |
| `costume list` | core.clj:751 | wardrobe read | costume table + liveness | 0 ✓ |
| `costume destroy` | core.clj:772 | wardrobe delete (refuses while live unless `--force`) | removal confirmation | 0 · 1 refused/failed · 2 usage (code-read) |
| `doctor` | `doctor.clj:629` | probe registry (machine pre-flight; no feature corpus) | probe table; `--list`; `--edn` | 0 all ok · 1 issues found ✓ |
| `init` | `init/init-cmd` init.clj (branch core.clj) | scaffold write: `sl/` config + glossary + starter feature; AGENTS.md only on `--write-agents` (marker-guarded; the default prints the offer); bails touch-nothing if `sl/shiftlefter.edn` exists, except the explicit `--write-agents` ask still lands | one line per artifact; AGENTS.md offer or outcome | 0 scaffolded AND 0 bailed (code-read; deliberately absent from `--help` until system-wide distribution) |
| `daemon serve` | `daemon-cmd` core.clj:810 | long-lived JVM serving `dispatch` over the wire (auto-spawned by `bin/sl`) | socket + port file | blocks; lifecycle codes on the client side |
| `daemon status` | core.clj:810 | registry read | daemon record (port/pid/jar) | 0 ✓ |
| `daemon stop` | core.clj:810 | signal + reap | stopped confirmation | 0 ✓ |
| `repl` | dispatch returns the `:repl` sentinel (core.clj:1017) — `-main` starts the REPL | blocks; no exit code by design (`dispatch` docstring) | interactive session / nREPL | n/a |
| `--version` | core.clj:962 | immediate | version string | 0 ✓ |
| `--help` | core.clj:929 | immediate | usage text | 0 |
| *(parse error)* | core.clj:922 | immediate | errors on stderr | 2 — a typo'd flag never executed anything |
| *(unknown command)* | core.clj:1019 | immediate | hint on stderr, stdout clean | 2 ✓ |


{: id="exit-codes-the-verdict-contract"}
## Exit codes: the verdict contract

The run family's column is one table, owned by `runner/verdict.clj` and
guard-tested against the docs (`exit-contract-guard-test`):

| Code | Status | Meaning |
|---|---|---|
| 0 | `:passed` | existential pass — ≥1 scenario selected, none failed/errored |
| 1 | `:failed` | ≥1 scenario failed (valid tests, app wrong) |
| 2 | `:planning-failed` | invalid before execution — nothing ran (config/parse/discovery/binding, un-runnable invocation, empty selection) |
| 3 | `:crashed` | runner crash; wins over everything (cold and warm paths both map Throwable → 3) |
| 4 | `:degraded` | ≥1 scenario `:error` — infrastructure failure; verdict about the app unavailable |

Precedence: 3 anywhere; 2 pre-execution exclusive; execution worst-wins
4 > 1 > 0. Non-run verbs reuse 0/1/2 with verb-local meanings (noted per
lane above); none of them can produce 3/4 short of a crash.


{: id="siblings"}
## Siblings

- [module map](/docs/architecture/module-map/) (require-graph truth)
- [REPL custody & lifetimes](/docs/architecture/repl-lifetimes/): where the `repl`
  lane's `:repl` sentinel hands off — the one surface where things
  outlive the invocation.
- [the data-shape ledger](/docs/architecture/data-shapes/): the values these verbs
  carry — every boundary-crossing shape with producer/spec/consumers/
  stability; its chain diagram is this map's data-flow dual.
- [the control loop](/docs/architecture/control-loop/): where `execute-and-report-stage`
  hands off — inside one scenario's execution, the ctx contract, and every
  failure path's honest exit.


{: id="how-this-map-stays-true"}
## How this map stays true

This page is a mechanical projection of a live-maintained internal map:
re-verified against the code by probe runs at each re-stamp, regenerated —
never hand-edited — by the derivation pipeline, and drift-guarded by the
test suite (a hand edit here fails a test). File:line pins are re-verified
at each re-stamp.
{% endraw %}
