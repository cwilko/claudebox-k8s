# Thin derivative of psyb0t/claudebox that only patches one thing: the base
# aicodebox entrypoint's UID/GID rematch step refuses to realign the `aicode`
# account onto an already-taken ID (e.g. Ubuntu's stock "users" group at GID
# 100 — a common collision with NFS/NAS exports using that same convention).
# entrypoint.sh here is psyb0t/docker-aicodebox's own entrypoint.sh with
# `-o`/`--non-unique` added to the groupmod/usermod calls, so that collision
# no longer aborts the whole container. See:
# https://github.com/psyb0t/docker-aicodebox/blob/master/entrypoint.sh
FROM psyb0t/claudebox:latest

COPY entrypoint.sh /usr/local/bin/aicodebox-entrypoint
RUN chmod +x /usr/local/bin/aicodebox-entrypoint
