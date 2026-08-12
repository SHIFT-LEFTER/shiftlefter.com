---
title: "The Pony Test"
---

*Hand a blinded agent nothing but your marketing pitch, ask it to derive your product, and grade what it imagines. A field note from the first run I've done.*

Users ask product teams for ponies - the adorable, expensive thing they don't understand and are never getting. The Pony Test doesn't ask whether users want a pony. It asks whether you told them they were getting one.

Last month I was rewriting my project's website copy: one value line and ten bullets - the differentiators, argued out of the codebase and the design docs by a panel of agents - written to hook a human without teaching them the whole product. When I ran cold readers to check how the pitch landed, they started announcing features I hadn't built. That was the accident. I made it deliberate: hand a fresh agent nothing but the bullets, zero other context, and ask it to derive the product. What commands exist? What happens on errors? What would you assume you could and couldn't do?

The blindfold is the whole trick. Ask a model to review your full product and it will mostly tell you it's great - you can't grade a compliment. Beg it to be brutally honest instead and it performs criticism, manufacturing nitpicks because you demanded some; you can't grade that either. But a model *predicting* your product can be wrong, and every guess checks against what actually exists. Hand it the manual and guessing the flags is reading comprehension. Hand it the pitch, and every guess is a derivation from a promise - each one carrying the exact sentence that licensed it.

It assumed forty-four things. I graded every one against the source: twelve existed, nineteen partially existed, thirteen didn't exist at all. Three of the missing thirteen were already on my private roadmap. It rederived my roadmap from marketing copy.

Then it did something I didn't ask for: it got nostalgic. Asked how it would use the tool, it wrote me a war story - a big redesign, hundreds of broken tests, days of red CI - a memory fabricated end to end by an agent that has no past. The hero of the fabricated memory was a command that does not exist. It hallucinated a feature and then wrote the testimonial for it. A hallucinated feature is a spec you already implied - apparently complete with sales collateral.

Every wrong guess got triaged to exactly one of three owners. The agent misread me: reader error - fix the ambiguity. My pitch overpromised: doc overclaim - fix the docs. Or the inference was sound and the thing just doesn't exist: design problem - free roadmap. My favorite was a guess that matched my product's stated philosophy better than my shipped defaults did. I filed that one against the product, not the docs. You can't triage a wish. You can triage an inference.

And it ships. One finding became a CI guard, and the guard went red on forty-nine stale documentation examples the first time it ran.

Fine print, three items. First, this worked as cleanly as it did because my product's users genuinely include agents - humans write these tests with an agent in the loop, and agents read the docs directly - so a fresh agent isn't simulating my user; it *is* one. If your users are humans, the gap between a real user and the persona an agent plays is real, and you have to account for it before trusting the results. Second, the accidental version of this experiment already happened, famously: Soundslice built an ASCII-tab import feature because ChatGPT kept telling users it existed and users kept showing up expecting it. I'm suggesting you do that on purpose, pre-release, with a grading rubric. Third, this is n=1 - one product, one big run. Take it as a method with one strong data point.

I'll definitely run it again. The mask can move - hide the API and hand it the CLI; hide the reporting layer and hand it the rest - and the reader can multiply: five models disagreeing about what's missing measures your docs' ambiguity, not the models' variance. The rule underneath all of it: every part of your product should be predictable from the rest. The parts that aren't are innovations or bugs - and you definitely want to know which.
