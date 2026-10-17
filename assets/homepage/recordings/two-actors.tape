# The two-actor run (sl-z6kt). Run from the staged example 02b:
#   cd /private/tmp/sl-homepage/02b && PATH=/private/tmp/sl-homepage/bin:$PATH vhs two-actors.tape
# `sl` on that PATH is a two-line wrapper around the dev repo's bin/sl --no-daemon.
# The feature file is printed before Show, so the gif's first frame is the
# feature, never an empty prompt (sl-4l16, A10 poster frame).
# The run opens two real Chrome windows (alice, bob) beside the terminal; the
# gif shows the terminal only. No cuts: the cold JVM start is on the clock.
Output two-actors.gif

Set Shell "bash"
Set FontSize 15
Set Width 1000
Set Height 620
Set Framerate 20
Set TypingSpeed 35ms
Set Padding 16

Hide
Type "export PS1='$ '; clear"
Enter
Type "cat sl/features/two-users.feature"
Enter
Sleep 500ms
Show
Sleep 3s

Type "sl run sl/features/"
Enter
Sleep 22s
