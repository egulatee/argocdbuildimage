#!/bin/sh

#base64 --help

echo 'Saving message'
echo $1 > message.base64
echo 'Saved message'


echo 'Decoding message'
base64 -d message.base64 > base64.json
echo 'Decoded message'

echo < base64.json

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
