#!/bin/sh

set -eux
#​git clone ssh://<git-repo-domain>/<reponame>
#cd <reponame>
echo "Param=" $1
set +u
if [ -z "$GIT_HASH" ] # Check if GIT_HASH exists
then
    set -u
    echo "GIT_HASH is empty, skipping git reset"
else
    set -u
    git reset --hard $GIT_HASH
fi
​
#echo Running $1
#source $1
