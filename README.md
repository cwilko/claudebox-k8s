# claudebox-k8s

A thin derivative of [`psyb0t/claudebox`](https://hub.docker.com/r/psyb0t/claudebox) that patches one
thing: the base [`aicodebox`](https://github.com/psyb0t/docker-aicodebox) entrypoint's UID/GID rematch
step aborts the entire container if the mounted workspace's owning UID or GID is already taken by a
*different* pre-existing account inside the image — e.g. Ubuntu's stock `users` group, permanently at
GID 100, which collides with any NFS/NAS export using that same convention (TrueNAS, Synology, and
others all default new shares to GID 100).

`entrypoint.sh` is upstream's own `entrypoint.sh`, unchanged except for adding `-o`/`--non-unique` to
the `groupmod`/`usermod` calls in that step, so a same-ID-different-account collision no longer aborts
startup. See [docker-aicodebox#entrypoint.sh](https://github.com/psyb0t/docker-aicodebox/blob/master/entrypoint.sh)
for the original.

Published to `docker.io/cwilko/claudebox-k8s:latest`, rebuilt on every push to `main` and weekly
(Mondays) to pick up changes to the upstream `psyb0t/claudebox:latest` base.
