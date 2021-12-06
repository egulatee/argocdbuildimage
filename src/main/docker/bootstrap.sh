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

echo '****'
cat messagepretty.json
echo '****'

export REPO_HTTPS_URL=`jq -r ".repository.clone_url" messagepretty.json`
echo 'REPO_HTTPS_URL=' $REPO_HTTPS_URL
export REPO_SSH_URL=`jq -r ".repository.ssh_url" messagepretty.json`
echo 'REPO_SSH_URL=' $REPO_GIT_URL
export REPO_GIT_URL=`jq -r ".repository.git_url" messagepretty.json`
echo 'REPO_GIT_URL=' $REPO_GIT_URL
export REPO_NAME=`jq -r ".repository.name" messagepretty.json`
echo 'REPO_NAME=' $REPO_NAME

#
# Configure GIT
#
#echo 'Configure GIT'
#git config --global credential.helper cache
#echo 'Setting username=' + $GH_USERNAME
#git config --global credential.https://github.com.username $GH_USERNAME
#echo 'Setting password=' + $GH_PASSWORD
#git config --global credential.https://github.com.password $GH_PASSWORD

#
# Checkout GIT
#
echo 'Setup for git'
mkdir /apps/
cd /apps/
#mkdir -p /root/.ssh/
#ls -alr /root/.ssh/
#cat /root/.ssh/ssh-privatekey
chmod u+x ~/.ssh/
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
#ls -ltr ~/.ssh/
#ls -ltr ~/.ssh/github_rsa/
ln -s ~/.ssh/github_rsa/ssh-privatekey ~/.ssh/id_rsa
ln -s ~/.ssh/github_rsa/ssh-publickey ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa

#
# Git cloning
#
echo 'Cloning!=' $REPO_SSH_URL
git clone $REPO_SSH_URL $REPO_NAME
echo 'Cloned!'

#find .
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
