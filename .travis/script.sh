#!/usr/bin/env bash
# coding=utf-8

# Run unit tests
# docker exec -it  fedora-28 /usr/local/lib/pulp/bin/python /var/lib/pulp/devel/pulpcore/manage.py test /var/lib/pulp/devel/pulpcore/pulpcore/tests/unit/

# Configure Smash
docker exec -it fedora-28 /usr/bin/mkdir -p /root/.config/pulp_smash/
docker exec -it fedora-28 /usr/bin/cp /var/lib/pulp/.config/pulp_smash/settings.json /root/.config/pulp_smash/settings.json

# Run functional tests
docker exec -it fedora-28 /usr/local/lib/pulp/bin/pytest -v -r sx --color=yes --pyargs pulpcore.tests.functional || show_logs_and_return_non_zero
docker exec -it fedora-28 /usr/local/lib/pulp/bin/pytest -v -r sx --color=yes --pyargs pulp_file.tests.functional || show_logs_and_return_non_zero

# # check the commit message
# ./.travis/check_commit.sh
#
# # Lint code.
# flake8 --config flake8.cfg
#
# # Run unit tests.
# coverage run manage.py test ./pulpcore/tests/unit/
#
# # Run functional tests, and upload coverage report to codecov.
# show_logs_and_return_non_zero() {
#     readonly local rc="$?"
#     cat ~/django_runserver.log
#     cat ~/content_app.log
#     cat ~/resource_manager.log
#     cat ~/reserved_worker-1.log
#     return "${rc}"
# }
#
# # Start services
# rq worker -n 'resource-manager@%h' -w 'pulpcore.tasking.worker.PulpWorker' -c 'pulpcore.rqconfig' >> ~/resource_manager.log 2>&1 &
# rq worker -n 'reserved-resource-worker-1@%h' -w 'pulpcore.tasking.worker.PulpWorker' -c 'pulpcore.rqconfig' >> ~/reserved_worker-1.log 2>&1 &
# gunicorn pulpcore.tests.functional.content_with_coverage:server --bind 'localhost:8080' --worker-class 'aiohttp.GunicornWebWorker' -w 2 >> ~/content_app.log 2>&1 &
# coverage run $(which pulp-manager) runserver --noreload >> ~/django_runserver.log 2>&1 &
# wait_for_pulp 20
#
# # Run functional tests
# pytest -v -r sx --color=yes --pyargs pulpcore.tests.functional || show_logs_and_return_non_zero
# pytest -v -r sx --color=yes --pyargs pulp_file.tests.functional || show_logs_and_return_non_zero
#
# # Stop services to write coverage
# kill -SIGINT %?runserver
# kill -SIGINT %?content_with_coverage
# kill -SIGINT %?reserved-resource-worker
# kill -SIGINT %?resource-manager
# wait || true
#
# coverage combine
# codecov
