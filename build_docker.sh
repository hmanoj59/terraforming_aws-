#!/usr/bin/env bash
aws_account_id="578526436642"
aws_region="us-east-1"


check_package() {
  which $1
  rc=$?
  if [[ $rc != 0 ]];
  then
  echo "$1 not installed exiting"
  exit $rc;
  fi
}
#Checking Docker and python packages in the local machine
check_package docker
check_package python

#Docker Commands to upload docker image to ecs repository
aws ecr create-repository --repository-name atom_wise_test_repo
command_output=$(aws ecr get-login --no-include-email --region $aws_region)
$command_output
docker build -t atom_wise_test_repo .
docker tag atom_wise_test_repo:latest $aws_account_id.dkr.ecr.$aws_region.amazonaws.com/atom_wise_test_repo:latest
docker push $aws_account_id.dkr.ecr.$aws_region.amazonaws.com/atom_wise_test_repo:latest
