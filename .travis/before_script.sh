#!/usr/bin/env sh
set -v

mkdir -p ~/.config/pulp_smash
cp .travis/pulp-smash-config.json ~/.config/pulp_smash/settings.json

# sudo mkdir -p /var/lib/pulp/tmp
# sudo mkdir /etc/pulp/
# sudo chown -R travis:travis /var/lib/pulp
