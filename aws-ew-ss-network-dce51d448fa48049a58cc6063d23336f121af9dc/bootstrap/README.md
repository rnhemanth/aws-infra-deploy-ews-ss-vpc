# S3 Remote State Storage

This module creates resources required to setup terraform s3 backend
* Amazon S3 bucket for terraform state
* Amazon S3 bucket for access logging for state bucket
* Amazon Dynamodb Table for backend locks

To deploy on a new instance:

1. You need to call this from a deployment repo using the relevant makefile and setup config in that repo
