#!/bin/sh

echo "Param0=" $0
echo "Param1=" $1
echo "Param2=" $2
echo "Param3=" $3
echo "Param4=" $4

echo 'Trying to decode'
echo $1 | base64 --decode


#set -eux
#​git clone ssh://<git-repo-domain>/<reponame>
#cd <reponame>
#echo "Param=" $1
#set +u
#if [ -z "$GIT_HASH" ] # Check if GIT_HASH exists
#then
#    set -u
#    echo "GIT_HASH is empty, skipping git reset"
#else
#    set -u
#    git reset --hard $GIT_HASH
#fi
​
#echo Running $1
#source $1
