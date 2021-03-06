#!/bin/sh

set -ex

if [ -f /tmp/host_packages.json ]; then
    if /tmp/compare-package-json.py < /tmp/host_packages.json ; then
        echo "Host package versions match, no update required"
        exit
    fi
fi

packages_for_update=
if [ -n "$1" ]; then
    packages_for_update=("$(repoquery --disablerepo='*' --enablerepo=$1 --qf %{NAME} -a)")
fi

yum -y update $packages_for_update
rm -rf /var/cache/yum
