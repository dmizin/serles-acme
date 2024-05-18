#!/bin/sh

/opt/serles_venv/bin/gunicorn -c /etc/serles/gunicorn_config.py 'serles:create_app()'
