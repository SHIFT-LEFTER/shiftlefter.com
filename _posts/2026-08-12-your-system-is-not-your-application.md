---
title: "Your System Is Not Your Application"
---

*Your application is the part you test. Your system is everything a user crosses on the way to their goal - and much of it ships unchecked.*

I've been talking to support chatbots lately. Last week it was a delivery company's. My package had gone from "delivery attempted" to "there's a problem," so I asked the bot what was going on. It confirmed my zip code - for privacy - looked into it, told me it could see the problem, and said it would file a ticket; I'd hear back soon. I was actually impressed. This was a good one.

Then: "Sorry - actually, I can't file a ticket."

Best case, their ticketing system happened to be down. The likelier read: the bot knew tickets were a thing that existed, promised one, and only then discovered it had no way to file anything. Another bot I've met starts answering questions about its own capabilities and then a second model scrubs the reply mid-sentence - you can watch the words vanish. A third resets the entire conversation if you ask what tools it can call.

John Gall's *Systemantics* saw all of this coming decades ago: "Intelligent machines, when they arrive, will demonstrate the inability of the human imagination to anticipate the truly bizarre and mind-boggling forms of malfunction of which complex Systems are capable." They've arrived. The malfunctions are as advertised.

Somewhere behind each of those bots is an engineering organization that would tell you, sincerely, that it takes quality seriously. And inside the repo, it does: there is a test suite and a CI gate; endpoints are asserted, regressions are caught before merge, dashboards are green. Then there is the thing wired to the front door, talking to actual customers in production - shipped with no checkable requirement at all, or with requirements written by whichever department managed to borrow a developer for a month.

This isn't an AI problem. AI just industrialized it. It's a boundary problem, and it's much older than chatbots: we quality-engineer the application, and we improvise everything else the user touches.

## To the user, it's all one system

A user arrives with a goal. It might be concrete - reset a password, file an expense - or as thin as "a friend said this was cool; is it?" The thin goals are the fragile ones: a determined user will push through a broken journey; a curious one is gone at the first wrong turn. Either way, the path crosses your marketing site, your docs, your onboarding flow, your pricing page, your error messages, your support inbox, your bug tracker. Every one of those things, you built. Every one of them, you control. Most of them will never see a requirement, a use case, or a test.

The user does not grade these separately. To someone trying to get something done, **a bug, a missing feature, and a help page listing hours nobody staffs are all the same kind of failure: the system didn't get them there.** The sizes differ; the category doesn't. (Christopher Alexander made this point about design in general sixty years ago - quality is mostly the absence of specific, pointable failures of fit. Users don't itemize whose fault each failure was.)

[Conway's Law](http://www.melconway.com/Home/Committees_Paper.html) - the 1968 observation that organizations produce designs copying their own communication structures - gets paraphrased as "you ship your org chart." You do. And the user walks across every seam in it: from marketing's landing page, through the docs team's tutorial, into engineering's product, out to support's inbox. Each group may run a tight ship. The journey crosses all four, and the journey is the product. It isn't a big-company disease, either: a five-person startup ships its org chart too - the seams just run between the hats one engineer wears before lunch.

## Where your system actually ends

So here is the definition I've been working with for a while.

Your **system** is everything you control that stands between a user and their goal. The **boundary** is where your control ends. Everything beyond it - app stores, network weather, data regulations, the user's patience - is **context**: the part of the world you have to contend with but cannot change.

Two useful things fall out of this immediately.

**The user's journey tells you where to look.** You enumerate your system's surfaces by walking the user's path, not by reading your repo list. If the user crosses it on the way to their goal, and you control it, it's part of your system - whichever department it reports to.

**Control tells you what you're accountable for.** You only partially control whether a user files a good bug report - they owe you nothing; they're doing you a favor. But your half of the exchange is fully yours. Open source learned this the hard way: projects spent years demanding precision from reporters while handing them a blank text box. The good ones now ship an issue template that asks for exactly what they need and a command that gathers the debug data so the reporter doesn't have to. That is quality engineering applied to the bug-filing journey, whether or not anyone calls it that.

The aim is never to control the user. It is to enable them and to engineer your half of every crossing instead of improvising it.

A last important point: these boundaries are too rarely drawn on purpose. Organizations inherit one - system equals application, because the application is the part engineering happens to control. Hold that thought.

## The requirements nobody writes down

Every organization already believes things like these:

- The docs exist, and you can find them from the homepage.
- The docs mention the feature that shipped last month.
- The docs no longer describe the feature you removed last year.
- The support address is correct, and the posted hours are actually staffed.
- A person can get from the landing page to help in two clicks.

Nobody disagrees with a single one of them. And in most organizations, not one is written down - which means not one is checked - which means each is quietly false some percentage of the time, discovered only by users, at the worst possible moment, with no ticket filed. (The unwritten requirement does enjoy one advantage: it has never once been violated.)

It is negligence, strictly speaking - but nobody's. Someone checked the hours page when it launched; then other plates needed spinning, and they moved on. Attention is an event; a requirement is a mechanism. Between the times somebody happens to look, nothing is holding these things true.

Notice that these are just requirements: boring, checkable, deterministic, present or absent, correct or incorrect, reachable or not. No judgment calls or taste required.

Then notice who owns them. Some sit squarely inside one department. Support knows its own workflow better than anyone; the knowledge and the authority are already in the room - what's missing is only the habit of writing the requirements down and checking them. Same for docs, same for onboarding. But the sharpest item on that list - help in two clicks - belongs to no department at all. Marketing owns the landing page. Support owns the help center. **The path between them is owned by nobody, which is exactly why it breaks silently.**

You don't need to reorganize the company to fix this, and you shouldn't try. Each department declares the requirements for its own surfaces - it already has the expertise and the authority. The requirements that span the seams need an owner: one named person with the standing to file a cross-team bug and have it taken seriously. Whether your organization will grant anyone that standing is a real question - but leaving the seams unowned answers it with a guarantee.

If your whole company fits in one room, the seams don't disappear - they move. There are no departments, so the surfaces become hats: some engineer is marketing on Thursday afternoon, support after standup. The requirements are even less written, because everything is tribal knowledge and the tribe is three people. But this is where the discipline is cheapest to adopt, and the forcing function has already arrived: the moment you hand one of those hats to an agent - "you are marketing; make this sellable" - you have to write down what that means. An agent can't absorb the unwritten from the room. **The prompt you hand it is already a requirements document - the only question is whether it's a good one.**

## The excuse expired

The obvious objection: you cannot write an assertion for whether the support agent was kind, whether the tutorial left someone feeling capable, whether the apology in your error message lands.

Correct. You can't. But this was always true of the application too. Nobody has ever tested software exhaustively; we test the deterministic fraction and reserve human judgment for the rest. Nothing new is being demanded here - just the same standard, extended to surfaces currently held to no standard at all. **Going from zero written requirements to the deterministic slice is the entire win.** Automate the verification you can, precisely so that scarce human attention goes where it is irreplaceable.

Also, the deterministic slice was never waiting on technology. A cron job and curl could have checked your support hours in 2005. "Help in two clicks" is a crawler and a counter. **What was missing was never tooling.** It was the decision to treat these surfaces as part of the system - to declare the requirements at all.

There are already names for pieces of this: synthetic monitoring, journey testing, docs linting. Good: the names mean the parts exist. What's been missing is the boundary that makes them one discipline instead of four departments' side projects.

What AI actually changes is the price of the middle ground. "The docs mention the feature" was always cheap to check. "The docs explain the feature well enough that a newcomer succeeds" needed fresh eyes, and QA has always known the trick for those: set the new hire loose on the product, because for a few weeks they still see everything the veterans have stopped seeing. Then they acclimate - "that's just how we do things here" - and the freshness is spent.

You can't re-blind a human. An agent is fresh on demand: the same cold read, on every release (at least until your product ends up in the training data). You can even cast the reader - a twelve-year-old, a hurried expert, a newcomer in their second language. The casting is imperfect; the blind spots it finds are real.

I fell into a version of this on my own project: agent cold readers, tasked with checking how a new website pitch landed, started announcing features I hadn't built. So I did it on purpose - a fresh agent, nothing but the pitch, no docs, no source: derive the product, and grade every guess against reality. It made [forty-four assumptions](/writing/2026/08/the-pony-test/). Some existed. Some half-existed. Some it invented outright - and a hallucinated feature is a spec you already implied. One finding became a CI guard that went red on forty-nine stale documentation examples the first time it ran.

And if your users include agents - for a growing class of products they already do - one classic objection dissolves on its own: the agent reading your docs isn't simulating your user anymore. It is one.

## Drawing the boundary is part of the work

A **system**, in full: the set of things someone controls in order to help a class of users change their world toward some goal. **Context** is everything else - everything that makes demands on your system without submitting to your control. The **boundary** between them is where control ends. (The vocabulary is older than software - Alexander's *Notes on the Synthesis of Form*, the 1964 book that eventually gave us design patterns, calls them form and context and defines them the same way.)

Which brings back the thought I asked you to hold. Drawing the boundary is part discovery and part decision. Discovery, because some of it isn't up to you: you cannot control the browser, the app store's review queue, the user's patience. You find those edges by hitting them. Decision, because inside the edges there's a real choice with real trade-offs: you *could* staff support around the clock - you choose "listed hours are correct" instead. Extending the boundary buys control and costs ownership; every surface you claim needs its requirements kept true.

**You discover what you *can* control. You decide what you *will*.** The failure mode is doing neither - leaving the boundary undrawn: a fuzzy region where nobody has checked what's controllable and nobody has committed to what's owned. An undrawn boundary doesn't stay blank; it defaults. The default is nearly always the same: system equals application, because the application is the part engineering happens to control. **That is not a drawn boundary. That's a defaulted one.** (Requirements tradition kept a slot for the decision - Cockburn's use-case template opens by asking which system, exactly, is under design.)

So draw it on purpose - find the edges, choose the line. Here is the smallest possible way to start.

## Monday

Everything above should sound obvious. That's the trap: most people already agree with all of it; almost nobody believes it. Belief shows up in what gets checked.

To figure out which one you're doing, pick a user journey that crosses a departmental seam - trial signup to first support ticket is a good one. Walk it yourself, as the user, in a clean browser. Write down at least five things that are supposed to be true along the way. Check them.

Maybe all five hold. Some organizations do have someone who keeps these things true - if that's yours, thank them, and maybe write down what they're doing before they leave. But my money says at least one is not quite right, and has been for a while - not because anyone was careless, but because there was no mechanism to keep it true. Application tests will never catch this - your system is not your application.
