#!/bin/bash

if [ $# -eq 0 ]
    then
    echo "no arguments supplied"
    echo "call: get_function_arn.sh <function-name>" 
    exit 1
fi
echo `aws lambda get-function --function-name $1 | grep -i functionarn | awk '{ print $2 }' | tr -d '"' | tr -d ','`
