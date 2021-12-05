#!/bin/sh

echo 'Saving message'
echo $1 > message.base64
echo 'Saved message'


echo 'Decoding message'
base64 -d message.base64 > message.json
echo 'Decoded message'

echo '***'
cat message.json
echo '***'

echo '****'
jq < message.json > messagepretty.json
echo '****'

echo '****'
cat messagepretty.json
echo '****'

export REPO_URL=`jq -r ".repository.clone_url" messagepretty.json`
echo 'REPO_URL=' $REPO_URL

git config credential.https://github.com.username $GH_USERNAME
git config credential.https://github.com.password $GH_PASSWORD
git clone $REPO_URL

