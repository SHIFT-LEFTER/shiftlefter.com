# G4 note — how the exit-4 artifact was produced

`deadport.txt` is a run against `http://127.0.0.1:9999/` with nothing
listening: the navigation step gets `ERR_CONNECTION_REFUSED`, the step is
classified `observation` ("no answer existed; this step proves nothing about
the app"), the scenario counts as `unobserved`, and the run exits 4.

One honest detail: port 1 does **not** produce this. Chrome refuses to
connect to its unsafe-port list itself and renders its own `ERR_UNSAFE_PORT`
error page — which loads successfully, so the navigation step passes, the
assertion step fails against the error page's text, and the run exits 1
(a verdict about the app). The exit-4 beat needs a port that is merely
closed, not one the browser refuses.

`ladder.txt` is assembled by the capture script from four runs it captured
in the same pass (the W3 run, the G1 hero, the G2 refusal, this one): the
command, the summary line, the exit. Exit 3 (a runner crash) is documented
in `docs/CI.md` and not staged here.
