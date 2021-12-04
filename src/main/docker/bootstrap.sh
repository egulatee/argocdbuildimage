#!/bin/sh

echo 'Saving message'
echo $1 > message.base64
echo 'Saved message'


echo 'Decoding message'
base64 -d message.base64 > base64.json
echo 'Decoded message'

echo '***'
cat base64.json
echo '***'
