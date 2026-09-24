# The fifteen-second exit-2 beat (sl-z6kt). Run from the staged dym project:
#   cd /private/tmp/sl-homepage/dym && PATH=/private/tmp/sl-homepage/bin:$PATH vhs exit-2.tape
# `sl` on that PATH is a two-line wrapper around the dev repo's bin/sl --no-daemon.
Output exit-2.gif

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
Show

Type "cat sl/features/login.feature"
Enter
Sleep 3s

Type "sl run sl/features/"
Enter
Sleep 7s

Type "echo $?"
Enter
Sleep 3s
