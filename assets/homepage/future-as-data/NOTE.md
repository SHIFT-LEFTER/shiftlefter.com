# Future-as-data note — what is data today, and what is not

`snippet.feature` carries a why-pointer: `@because=CHK-4412`. It is an
ordinary value-shaped tag — every tag is typed `@key=value` at planning —
and the pointer is opaque to the framework (see `sl agent-doc authoring`).

`def-site.edn` is the `--edn` planning fragment of the refusal run in
`g2-before-the-run/`: every issue names where the right thing is declared
(`:def-site {:file "sl/glossary/subjects.edn" :line 10 :entry :user/alice}`
for the typo'd subject; `:def-site {:file "shiftlefter/stepdefs/browser.clj"
:line 675}` for the typo'd verb, with the repaired step text).

**Not shown, because it is not shipped:** the use-case artifact's
`:evidence` binding is 0.6. The only `:evidence` keys in the codebase today
belong to SIEVE's evidence snapshots (a dev/REPL preview), not to any
scenario, run, or use-case shape. This beat shows the two inputs the graph
will read — the why-pointer and the def-site — and nothing that does not
exist yet.
