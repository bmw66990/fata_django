#!/bin/sh
gunicorn -c gunicorn.conf.py api_leakage.wsgi
