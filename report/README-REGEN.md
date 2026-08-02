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

## Hard constraints

- **Released artifact only.** Extract the release zip (or install via the
  public one-liner) and run its jar. Verify `sl --version` prints the tag.
- **Neutral cwd.** The report embeds absolute paths. Run from
  `/private/tmp/shiftlefter-demo` (or any path containing no username or
  hostname). The first 0.5.1 attempt leaked `/Users/...` paths this way.
- **Stage the corpus at its OWN relative path, pid segment included.** The
  generator writes under `target/corpus/p<pid>/default-42` (sl-7rb6), and
  the serial/control marker steps bake that relative path into their step
  text. Staging at any other relative path breaks all 9 marker scenarios
  (9 spurious failures — caught in the sl-9009 dress rehearsal).
- **Hooks law (sl-esq):** `hooks.clj` is discovered ONLY as a sibling of the
  ACTIVE `shiftlefter.edn`; with no config file in cwd, hooks are off. The
  corpus ships `hooks.clj` at its root and its features carry `@hook=` tags,
  so with this corpus the misconfiguration is loud, not silent: a run that
  can't discover `hooks.clj` fails planning (exit 2, "Unknown hook
  name(s)... no hooks.clj found next to the active shiftlefter.edn") and
  writes no report. Stage `hooks.clj` + the strict config into the demo cwd
  (recipe step 3) and the sample keeps its historical strict-pending
  presentation (`:allow-pending? false`, same as the pre-hook samples).
- **Leak-check before committing** (must print the tag version, then `0`):

  ```bash
  grep -o ':version "[^"]*"' report.html
  grep -c "gjw\|/Users/\|$(hostname -s)" report.html
  ```

## Recipe

```bash
# 1. Neutral dir + release artifact
mkdir -p /private/tmp/shiftlefter-demo && cd /private/tmp/shiftlefter-demo
unzip -q <dev-repo>/target/shiftlefter-vX.Y.Z.zip   # or the public one-liner

# 2. Materialize the corpus (from the dev repo — test-classpath code).
#    CORPUS is repo-relative and INCLUDES the p<pid> segment (sl-7rb6).
cd <dev-repo>
CORPUS=$(java -cp "$(clojure -Spath -A:test)" clojure.main -e \
  "(require '[shiftlefter.corpus.generator :as gen]) \
   (println (:dir (gen/write-corpus! {:profile :default :seed 42})))" | tail -1)
echo "$CORPUS"   # e.g. target/corpus/p12345/default-42

# 3. Stage: corpus under the SAME relative layout (pid segment preserved —
#    marker steps bake it), steps fixture cwd-relative, and the hook pair in
#    cwd: hooks.clj (sibling-of-config discovery) + a strict one-line config
#    (NOT the corpus's own config — that is :allow-pending? true for the
#    acceptance suite; the sample has always run strict).
cd /private/tmp/shiftlefter-demo
mkdir -p "$(dirname "$CORPUS")" test/fixtures/steps
cp -R <dev-repo>/"$CORPUS" "$(dirname "$CORPUS")"/
cp <dev-repo>/test/fixtures/steps/corpus_steps.clj test/fixtures/steps/
cp "$CORPUS"/hooks.clj .
echo '{:runner {:allow-pending? false}}' > shiftlefter.edn

# 4. Run through the release jar — exit 1 expected (deliberate failures)
java -jar shiftlefter-vX.Y.Z/shiftlefter-vX.Y.Z.jar run \
  "$CORPUS"/features \
  --step-paths test/fixtures/steps/corpus_steps.clj \
  --html report.html
# Sanity: summary line reads 41 scenario(s): 28 passed, 6 failed, 1 error,
# 6 pending — and report.html contains corpus-audit / corpus-cleanup-fails /
# hook/after-failed / corpusSeeded, PLUS the description-prose pin:
# grep -c "value-tags" report.html   # >= 1 — the 10_hooks feature description
# (sl-v85e). Zero means the regen did NOT carry pickle descriptions: wrong
# jar or stale corpus — stop and fix before installing.

# 5. Leak-check (above), then install
cp report.html <sl-vision>/shiftlefter/website/report/index.html

# 6. og:image / proof thumbnail (1200x630)
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless \
  --disable-gpu --hide-scrollbars --window-size=1200,630 \
  --screenshot=report-screenshot.png \
  "file:///private/tmp/shiftlefter-demo/report.html"
cp report-screenshot.png <sl-vision>/shiftlefter/website/report-screenshot.png
```

Then: commit in sl-vision, Chair reviews, Chair deploys by manual SFTP
(index.html, llms.txt, report-screenshot.png, shiftlefter-noname.png,
report/index.html — and this file rides along harmlessly; it contains only
public-repo information).

Note: the corpus's `10_hooks.feature` carries Gherkin description prose
(feature + scenario level). Since sl-v85e (0.5.3) the pickler carries it and
the HTML report renders it — the sample now showcases BOTH the 9009 hook
lines and the v85e descriptions, and the step-4 `value-tags` grep is the
mechanical proof the regen carried them.
