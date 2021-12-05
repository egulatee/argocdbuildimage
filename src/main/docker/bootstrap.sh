#!/bin/sh

echo 'Saving message'
echo $1 > message.base64
echo 'Saved message'


echo 'Decoding message'
base64 -d message.base64 > message.json
echo 'Decoded message'

#echo '***'
#cat message.json
#echo '***'

echo '****'
jq < message.json > messagepretty.json
echo '****'

#echo '****'
#cat messagepretty.json
#echo '****'

export REPO_URL=`jq -r ".repository.clone_url" messagepretty.json`
echo 'REPO_URL=' $REPO_URL
export REPO_NAME=`jq -r ".repository.name" messagepretty.json`
echo 'REPO_NAME=' $REPO_NAME

#
# Configure GIT
#
echo 'Configure GIT'
export GIT_ASKPASS=no
git config --global credential.helper cache
echo 'Setting username'
#echo 'Setting username=' + $GH_USERNAME
git config --global credential.https://github.com.username $GH_USERNAME
echo 'Setting password'
#echo 'Setting password=' + $GH_PASSWORD
git config --global credential.https://github.com.password $GH_PASSWORD

#
# Checkout GIT
#
echo 'Cloning!'
mkdir /apps/
cd /apps/
git clone $REPO_URL
echo 'Cloned!'

find .

#
# Logging into ARGOCD
#
echo 'Logging into ArgoCD'
argocd login argocd-server.argocd --insecure --username $ARGO_USERNAME --password $ARGO_PASSWORD
echo 'Logged into ArgoCD'

cd $REPO_NAME

#
# Submit ARGOCD workflow
#
export WORKFLOW_FILE=".argocd/workflow.yaml"
if [ -f "$WORKFLOW_FILE" ]; then
    echo "$WORKFLOW_FILE exists."
    argocd submit .argocd/workflow.yaml
else
    echo "$WORKFLOW_FILE doesn't exist."
fi

