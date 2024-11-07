FROM python:3.12-slim

# curl below just for testing - can be removed
# gettext is to replace plceholders in config.ini.template on startup
RUN apt-get update && apt-get install -y gettext curl && rm -rf /var/lib/apt/lists/*
RUN python -m venv /opt/serles_venv
RUN /opt/serles_venv/bin/pip install serles-acme

# copy start.sh and entrypoint.sh
COPY --chown=root:root /app /usr/local/bin/

# copy template files to /etc/serles
COPY --chown=root:root /files /etc/serles

# copy updated for DNS-01 files to app; update for Python version
COPY --chown=root:root /serles /opt/serles_venv/lib/python3.12/site-packages/serles

RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/start.sh

EXPOSE 8000/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["sh", "-c", "umask 002 && /usr/local/bin/start.sh"]
