# assets/homepage — the front page's evidence

Every file in this tree was **captured from a real run** of the ShiftLefter
jar; nothing here was typed as output. The only hand-written files are this
index and the two `NOTE.md`s.

Beside every artifact sits `<file>.stamp.edn`: the dev-repo commit, the
`sl --version`, the source project, the exact command, its exit code, the
date, the browser versions, the scrub rules that fired, and the command that
regenerates it. Regeneration lives in the shiftlefter repo at
`scripts/homepage/` (`scripts/homepage/capture.sh all`); its README documents
the scrub table. Scrubbed: the staging path prefix, host name, WebDriver
session id and port, run seed, uuids, instants, measured durations,
attachment byte counts, results-dir stamps. Never scrubbed: step text,
messages, counts, exit codes, poll counts, actor and intent names, and every
`file:line`.

| dir | card | what is in it |
|---|---|---|
| `w1-dataplane/` | W1 — the data plane | a value captured from an SMS in one step and typed into a browser in the next; the green run |
| `w2-nested/` | W2 — nested page objects | `Cart.items[-1].remove` clicked, `3 Cart.items[*].price elements` counted, `Thread.post[1].comment[-1].author` read; the declared `cart.edn` / `item.edn` |
| `w3-actors/` | W3 — actors | alice and bob in one scenario, two browsers; the resolved glossary; the (empty) costume list |
| `g1-failure/` | G1 — the failure report | one real failure: actor, intent, step, screenshot and console, as console text, EDN, JUnit, and the self-contained HTML report (`report.html` + `attachments/`); `failure-row.png` is that report's row as a browser renders it |
| `g2-before-the-run/` | G2 — before the run | the dry-run plan (every step → its stepdef, file:line) and a refusal: two typos, two did-you-means, the `Declared in:` line, exit 2, no browser opened |
| `g4-exit-contract/` | G4 — the exit contract | a closed port → `1 unobserved`, exit 4; `ladder.txt` — four captured runs, exits 0 / 1 / 2 / 4 |
| `g7-agents-door/` | G7 — the agents door | the packaged topic list, one topic, `sl orient`, and a plain Cucumber suite refused with the shift hint |
| `p3-parallel/` | P3 | the same suite sequential and `--max-parallel 4`; `diff.txt` is empty |
| `p4-two-passes/` | P4 | `sl fmt` on a suite with no step definitions and no config |
| `future-as-data/` | the future as today's data | an `@because=` why-pointer and the `:def-site` every planning issue carries; `NOTE.md` says what is not shipped |
| `recordings/` | the two recordings | `exit-2` (the fifteen-second refusal) and `two-actors`; each as `.gif`, the VHS `.tape` that produced it, and a `.txt` transcript of the same commands |

Reference scheme for the page: `/assets/homepage/<dir>/<file>`.
