---
layout: default
title: Docs
permalink: /docs/
---
<article class="essay doc docs-index">
  <header class="essay-header">
    <p class="kicker">Docs</p>
    <h1>Docs</h1>
    <p class="standfirst">The readable half of the ShiftLefter documentation: the guides people actually send each other, and the architecture reports that say how the thing is built. Synced from the <a href="https://github.com/shift-lefter/shiftlefter">repository</a>; the repository owns the content.</p>
  </header>

  <h2>Guides</h2>
  <ul>
    <li><a href="/docs/reports/">Build your own report</a><span>There is no reporting plugin API, on purpose. The machine record — the <code>--edn</code> summary stream plus the run directory — is the extension contract; this walks a complete derived report.</span></li>
    <li><a href="/docs/costumes/">Costumes</a><span>A persona's durable browser character — a named Chrome profile an actor wears through an interface — and the plan-time checks that keep wear honest.</span></li>
    <li><a href="/docs/hooks/">Hooks — and when not to use them</a><span>Scenario lifecycle hooks named in the feature file, stamped in the run's evidence — and the ladder of things to reach for before them.</span></li>
    <li><a href="/docs/extending-vocabulary/">Add domain language</a><span>Your own domain language comes from data you author — glossaries, macros, intents — not step code; declaring vocabulary types it without giving it behavior.</span></li>
    <li><a href="/docs/ci/">Running ShiftLefter in CI</a><span>Exit codes, JUnit XML, tag filtering, parallelism, and the cold/warm paths as a pipeline sees them.</span></li>
  </ul>

  <h2>Architecture</h2>
  <p>Six reports and an index page, each checked against the code itself rather than drawn from memory. They date themselves; read the stamp.</p>
  <ul>
    <li><a href="/docs/architecture/">The Architecture Pages</a><span>The front door: six documents, one method — each page checked against the code it describes, on a recorded date, by a stated procedure.</span></li>
    <li><a href="/docs/architecture/invocation-map/">The Invocation Map</a><span>Every <code>sl</code> verb through the shared spine — one dispatch, cold and warm alike.</span></li>
    <li><a href="/docs/architecture/module-map/">Module Map</a><span>The namespace dependency graph as extracted from the require forms, with the laws it is checked against.</span></li>
    <li><a href="/docs/architecture/control-loop/">The Control Loop</a><span>Inside one scenario's execution: provisioning, hooks, the step loop, capture, cleanup, verdict.</span></li>
    <li><a href="/docs/architecture/data-shapes/">The Data-Shape Ledger</a><span>Every boundary-crossing shape with its producer, spec, consumers, and stability promise.</span></li>
    <li><a href="/docs/architecture/repl-lifetimes/">REPL Custody &amp; Lifetimes</a><span>Who owns what in the REPL and the daemon, and how long each thing lives.</span></li>
    <li><a href="/docs/architecture/exit-codes/">Exit Codes</a><span>The ladder: five codes, the axis that orders them, and the error-class contract that keeps a green honest.</span></li>
  </ul>

  <p class="note">Not here on purpose: the generated API reference and the agent-facing doctrine topics — those live in the repository and travel with each release.</p>
</article>
