#!/bin/bash

NAME="todo-app"                              #Name of the application (*)
DJANGODIR=/home/bigz3ro/todo-django/src/             # Django project directory (*)
SOCKFILE=/home/bigz3ro/todo-django/gunicorn/gunicorn.sock        # we will communicate using this unix socket (*)
USER=bigz3ro                                        # the user to run as (*)
GROUP=www-data                                     # the group to run as (*)
NUM_WORKERS=3                                     # how many worker processes should Gunicorn spawn (*)
DJANGO_SETTINGS_MODULE=core.settings             # which settings file should Django use (*)
DJANGO_WSGI_MODULE=core.wsgi                     # WSGI module name (*)

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source /home/bigz3ro/todo-django/env/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec /home/bigz3ro/todo-django/env/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user $USER \
  --bind=unix:$SOCKFILE
