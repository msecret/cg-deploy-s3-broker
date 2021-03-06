#!/bin/bash

set -e
set -u

cat << EOF > credentials.json
{
  "username": "${AUTH_USERNAME}",
  "password": "${AUTH_PASSWORD}",
  "s3_config": {
    "region": "${AWS_REGION}",
    "aws_partition": "${AWS_PARTITION}",
    "user_prefix": "${USER_PREFIX}",
    "policy_prefix": "${POLICY_PREFIX}",
    "bucket_prefix": "${BUCKET_PREFIX}",
    "iam_path": "${IAM_PATH}"
  }
}
EOF

cp -r broker-src/. broker-src-built

jq -s '.[0] * .[1]' broker-config/config-template.json credentials.json > \
  broker-src-built/config.json
