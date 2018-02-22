#!/bin/bash

ARN=`aws iam list-roles | grep $1 | grep Arn | awk '{ print $2 }' | tr -d '"' | tr -d ','`
echo $ARN
