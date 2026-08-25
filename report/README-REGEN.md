# Regenerating the /report sample (per release)

The `/report/index.html` sample is a real `sl run` artifact: the failing
corpus run (`default-42` — 41 scenarios: 28 passed / 6 failed / 6 pending /
1 error, the error being a deliberately failing After hook), executed through
the **tagged release jar**, never an in-process source run (source runs stamp
`vunknown`; the jar stamps the release version into the EDN island). Chair
ruling (sl-y15o): the failing corpus is the primary sample because one
artifact shows the whole status vocabulary plus the failure UX — including,
since sl-9009, the lifecycle-hook lines (sl-esq): per-hook transcript rows
with contributed keys, and a scenario-level hook error with LIFO unwind —
and, since sl-v85e, Gherkin description prose rendered under the feature
heading and inside expanded scenarios (the corpus's `10_hooks.feature`
carries both levels).
Regenerate after every tag (the sl-asam lineage checklist, row 8a).
Since sl-6hsd there is a SECOND artifact: `/report/planning.html`, the
planning-failure sample (step 5b) showing the s04n/bav1 grammar-hint
teaching UX — regenerate it in the same pass, same jar, same corpus.

## Hard constraints

- **Released artifact only.** Extract the release zip (or install via the
  public one-liner) and run its jar. Verify `sl --version` prints the tag.
- **Neutral cwd.** The report embeds absolute paths. Run from
  `/private/tmp/shiftlefter-demo` (or any path containing no username or
  hostname). The first 0.5.1 attempt leaked `/Users/...` paths this way.
  Since sl-l9nj (0.5.4) the island also embeds the run's results-dir path
  (`results/<stamp>/` under the demo cwd — the run creates that dir and
  writes the report's primary inside it; the `--html` path you point at is
  a byte copy, so step 5's `cp` is unchanged) — one more absolute path the
  neutral-cwd rule is load-bearing for; the leak-check grep covers it.
- **Stage the corpus at its OWN relative path, pid segment included.** The
  generator writes under `target/corpus/p<pid>/default-42` (sl-7rb6), and
  the serial/control marker steps bake that relative path into their step
  text. Staging at any other relative path breaks all 9 marker scenarios
  (9 spurious failures — caught in the sl-9009 dress rehearsal).
- **Hooks law (sl-esq) under layout C (sl-fcjm):** config discovery finds
  ONLY `<root>/sl/shiftlefter.edn` — a root-level `shiftlefter.edn` in cwd
  is ignored (this recipe staged it there until 0.5.4; that now fails).
  `hooks.clj` is discovered ONLY as a sibling of that ACTIVE config; with
  no discovered config, hooks are off. The corpus ships `hooks.clj` at
  `$CORPUS/sl/hooks.clj` (not the corpus root) and its features carry
  `@hook=` tags, so with this corpus the misconfiguration is loud, not
  silent: a run that can't discover `hooks.clj` fails planning (exit 2,
  "Unknown hook name(s)... no hooks.clj found next to the active
  shiftlefter.edn") and writes no report. Stage `hooks.clj` + the strict
  config into the demo dir's `sl/` (recipe step 3) and the sample keeps
  its historical strict-pending presentation (`:allow-pending? false`,
  same as the pre-hook samples).
- **Leak-check before committing** (must print the tag version, then `0`):

  ```bash
  grep -o ':version "[^"]*"' report.html
  grep -c "gjw\|/Users/\|$(hostname -s)" report.html
  ```

## Recipe

```bash
# 1. Neutral dir + release artifact via the public one-liner (preferred —
#    it re-verifies the public install path in the same pass). It installs
#    into ./sl/, which is ALSO the layout-C config dir; that collision is
#    fine — step 3 drops the config next to the jar.
mkdir -p /private/tmp/shiftlefter-demo && cd /private/tmp/shiftlefter-demo
curl -fsSL https://raw.githubusercontent.com/SHIFT-LEFTER/shiftlefter/main/release/install.sh | bash
sl/sl --version   # must print the tag
# (fallback: unzip -q <dev-repo>/target/shiftlefter-vX.Y.Z.zip — then the
#  jar lives at shiftlefter-vX.Y.Z/shiftlefter-vX.Y.Z.jar and you still
#  create sl/ yourself in step 3)

# 2. Materialize the corpus (from the dev repo — test-classpath code).
#    CORPUS is repo-relative and INCLUDES the p<pid> segment (sl-7rb6).
cd <dev-repo>
CORPUS=$(java -cp "$(clojure -Spath -A:test)" clojure.main -e \
  "(require '[shiftlefter.corpus.generator :as gen]) \
   (println (:dir (gen/write-corpus! {:profile :default :seed 42})))" | tail -1)
echo "$CORPUS"   # e.g. target/corpus/p12345/default-42

# 3. Stage: corpus under the SAME relative layout (pid segment preserved —
#    marker steps bake it), steps fixture cwd-relative, and the hook pair at
#    sl/ (layout C: sl/shiftlefter.edn is the only discovered config, and
#    hooks.clj must sit beside it). Use a strict one-line config (NOT the
#    corpus's own — that is :allow-pending? true for the acceptance suite;
#    the sample has always run strict).
cd /private/tmp/shiftlefter-demo
mkdir -p "$(dirname "$CORPUS")" test/fixtures/steps sl
cp -R <dev-repo>/"$CORPUS" "$(dirname "$CORPUS")"/
cp <dev-repo>/test/fixtures/steps/corpus_steps.clj test/fixtures/steps/
cp "$CORPUS"/sl/hooks.clj sl/
echo '{:runner {:allow-pending? false}}' > sl/shiftlefter.edn

# 4. Run through the release jar — exit 4 expected since sl-7c7i (the
#    deliberate After-hook error degrades the run: header badge DEGRADED;
#    through 0.5.4 this was exit 1 / FAILED)
java -jar sl/shiftlefter-vX.Y.Z.jar run \
  "$CORPUS"/features \
  --step-paths test/fixtures/steps/corpus_steps.clj \
  --html report.html
# Sanity: summary line reads 41 scenario(s): 28 passed, 6 failed, 1 error,
# 6 pending — and report.html contains corpus-audit / corpus-cleanup-fails /
# hook/after-failed / corpusSeeded, PLUS the description-prose pin:
# grep -c "value-tags" report.html   # >= 1 — the 10_hooks feature description
# (sl-v85e). Zero means the regen did NOT carry pickle descriptions: wrong
# jar or stale corpus — stop and fix before installing.

# 5. Leak-check (above), then install into the shiftlefter.com repo
cp report.html ~/dev/shiftlefter.com/report/index.html

# 5b. Planning-failure sample (sl-6hsd): the corpus's broken/ quarantine
#     through the same jar — exit 2 EXPECTED, and since sl-6hsd the run
#     still writes the HTML report (zero scenarios, diagnostics island).
#     The page shows the s04n grammar-hint teaching UX: B-002 draws the
#     prose-as-step hint (sl-bav1), B-001 shows the hint-less undefined
#     case beside it. Same leak-check applies (tag version, then 0).
java -jar sl/shiftlefter-vX.Y.Z.jar run \
  "$CORPUS"/broken \
  --step-paths test/fixtures/steps/corpus_steps.clj \
  --html report-planning.html
# Sanity: exit code 2; page header PLANNING FAILED; grep both:
# grep -c "grammar/prose-as-step" report-planning.html   # >= 1
# grep -c "corpus step that no stepdef defines" report-planning.html  # >= 1
cp report-planning.html ~/dev/shiftlefter.com/report/planning.html

# 6. og:image / proof thumbnail (1200x630)
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless \
  --disable-gpu --hide-scrollbars --window-size=1200,630 \
  --screenshot=report-screenshot.png \
  "file:///private/tmp/shiftlefter-demo/report.html"
cp report-screenshot.png ~/dev/shiftlefter.com/report-screenshot.png
# OPEN THE PNG BEFORE COMMITTING. The report renders client-side from the
# EDN island, and headless Chrome can shoot before render (a ~3.5 KB solid
# dark PNG is the tell; a real one is ~95 KB). If the running Chrome
# instance swallows the headless flags, fall back to a windowed capture:
# serve the site locally, open /report/ at a 1200x630-proportioned viewport,
# capture, and `sips -z 630 1200 shot.jpg --out report-screenshot.png`.
```

**Render-check law (added at the 0.5.5 site session, sl-73lb):** open BOTH
regenerated pages in a real browser before installing them. The JVM suite
cannot execute the report's JavaScript, so a renderer regression ships
silently as a blank `#app` with perfect counts and a clean leak-check — the
sl-t86d badge rewrite did exactly that (`ReferenceError: planningFailed`)
and the regen was the first browser render to catch it. Badge + counts on
screen, zero console errors, then install.

Then: one commit in ~/dev/shiftlefter.com, Chair reviews, and the deploy is
GitHub Pages from the `github` remote's `main` (SFTP is retired; first Pages
deploy verified live 08-05, sl-y5qw). That branch is server-side
PR-protected — direct push is rejected (GH006) even for admins and
`ALLOW_PUBLISH=1` only satisfies the local hook — so push a branch, open a
PR, merge it, then fast-forward the merge commit back to GitLab `origin`
main so the remotes don't fork. The site repo carries a ride-along copy of
this file (report/README-REGEN.md, public-repo information only); it may
drift harmlessly between passes — refresh it in the next regen commit.

Note: the corpus's `10_hooks.feature` carries Gherkin description prose
(feature + scenario level). Since sl-v85e (0.5.3) the pickler carries it and
the HTML report renders it — the sample now showcases BOTH the 9009 hook
lines and the v85e descriptions, and the step-4 `value-tags` grep is the
mechanical proof the regen carried them.
