#!/bin/bash
NOW=$(date +"%Y-%m-%d")
NOW_TIME=$(date +"%Y-%m-%d_%T_%p")
NOW_MONTH=$(date +"%Y-%m")
WEBSITE_NAME=$1
S3_BUCKET_NAME=$2
path="/home/static/$WEBSITE_NAME"
rm -rf "$path"
mkdir -p "$path"
wget -k -K -E -r -l 10 -p -N -F --restrict-file-names=windows -nH http://${WEBSITE_NAME} -P ${path}
aws s3 cp s3://${S3_BUCKET_NAME} s3://${S3_BUCKET_NAME}/old/$NOW_TIME --recursive --exclude "old/*" --profile testprofile


aws s3 sync "$path" s3://${S3_BUCKET_NAME} --profile testprofile
# aws s3 sync "/home/static/spark.alaabishtawi.com/" s3://staticwp.alaabishtawi.com --dryrun
