#!/usr/bin/env sh
set -v

# psql -U postgres -c 'CREATE USER pulp WITH SUPERUSER LOGIN;'
# psql -U postgres -c 'CREATE DATABASE pulp OWNER pulp;'

# pwd
# /home/travis/build/asmacdo/pulpcore
# ls /home/travis/build/asmacdo/pulpcore
# ls /home/travis/build/asmacdo/pulpcore/pulpcore
cd ..
git clone https://github.com/asmacdo/ansible-pulp3.git
# git clone https://github.com/pulp/pulpcore.git
git clone https://github.com/pulp/pulpcore-plugin.git
git clone https://github.com/pulp/pulp_file.git
#


Install latest ansible
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible
ansible-playbook --version

# Run Ansible playbook
cp pulpcore/.travis/playbook.yml ansible-pulp3/playbook.yml
pushd ansible-pulp3
git checkout origin/listen-localhost
ansible-galaxy install -r requirements.yml
ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml -vvv
popd

# # dev_requirements should not be needed for testing; don't install them to make sure
# pip install "Django<=$DJANGO_MAX"
# pip install -r test_requirements.txt
# pip install -e .
#
# if [ "$TEST" = 'docs' ]; then
#   pip3 install -r doc_requirements.txt
#   return "$?"
# fi
#
# export COMMIT_MSG=$(git show HEAD^2 -s)
# export PULP_FILE_PR_NUMBER=$(echo $COMMIT_MSG | grep -oP 'Required\ PR:\ https\:\/\/github\.com\/pulp\/pulp_file\/pull\/(\d+)' | awk -F'/' '{print $7}')
# export PULP_SMASH_PR_NUMBER=$(echo $COMMIT_MSG | grep -oP 'Required\ PR:\ https\:\/\/github\.com\/PulpQE\/pulp-smash\/pull\/(\d+)' | awk -F'/' '{print $7}')
# export PULP_PLUGIN_PR_NUMBER=$(echo $COMMIT_MSG | grep -oP 'Required\ PR:\ https\:\/\/github\.com\/pulp\/pulpcore-plugin\/pull\/(\d+)' | awk -F'/' '{print $7}')

# if [ -z "$PULP_PLUGIN_PR_NUMBER" ]; then
  # git fetch origin +refs/pull/$PULP_PLUGIN_PR_NUMBER/merge
# if [ -z "$PULP_PLUGIN_PR_NUMBER" ]; then
#   pip install git+https://github.com/pulp/pulpcore-plugin.git
# else
#   cd ../
#   git clone https://github.com/pulp/pulpcore-plugin.git
#   cd pulpcore-plugin
#   git fetch origin +refs/pull/$PULP_PLUGIN_PR_NUMBER/merge
#   git checkout FETCH_HEAD
#   pip install -e .
#   cd ../pulp
# fi
#
# if [ -z "$PULP_FILE_PR_NUMBER" ]; then
#   pip install git+https://github.com/pulp/pulp_file.git#egg=pulp_file
# else
#   cd ../
#   git clone https://github.com/pulp/pulp_file.git
#   cd pulp_file
#   git fetch origin +refs/pull/$PULP_FILE_PR_NUMBER/merge
#   git checkout FETCH_HEAD
#   pip install -e .
#   cd ../pulp
# fi
#
# if [ ! -z "$PULP_SMASH_PR_NUMBER" ]; then
#   pip uninstall -y pulp-smash
#   cd ../
#   git clone https://github.com/PulpQE/pulp-smash.git
#   cd pulp-smash
#   git fetch origin +refs/pull/$PULP_SMASH_PR_NUMBER/merge
#   git checkout FETCH_HEAD
#   pip install -e .
#   cd ../pulp
# fi
