#!/usr/bin/env sh
set -v

mkdir -p ~/.config/pulp_smash
cp .travis/pulp-smash-config.json ~/.config/pulp_smash/settings.json

# sudo mkdir -p /var/lib/pulp/tmp
# sudo mkdir /etc/pulp/
# sudo chown -R travis:travis /var/lib/pulp

# Run migrations.
export DJANGO_SETTINGS_MODULE=pulpcore.app.settings
export PULP_CONTENT_HOST=localhost:8080
# django-admin migrate --noinput

if [ "$TEST" != 'docs' ]; then
  django-admin makemigrations file --noinput
  django-admin migrate --noinput
fi
