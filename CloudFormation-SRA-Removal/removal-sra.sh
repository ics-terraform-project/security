#!/bin/bash

# CloudWatch Log Groups
aws logs describe-log-groups --query 'logGroups[?contains(logGroupName, `sra`)].logGroupName' --output text | while read -r logGroupName; do
    aws logs delete-log-group --log-group-name "$logGroupName"
done

# CloudFormation Stacks
aws cloudformation describe-stacks --query 'Stacks[?contains(StackName, `sra`)].StackName' --output text | while read -r stackName; do
    aws cloudformation delete-stack --stack-name "$stackName"
done

# SSM Parameters
aws ssm describe-parameters --query 'Parameters[?contains(Name, `sra`)].Name' --output text | while read -r paramName; do
    aws ssm delete-parameter --name "$paramName"
done

# IAM Roles
aws iam list-roles --query 'Roles[?contains(RoleName, `sra`)].RoleName' --output text | while read -r roleName; do
    # Detach policies first
    attachedPolicies=$(aws iam list-attached-role-policies --role-name "$roleName" --query 'AttachedPolicies[].PolicyName' --output text)
    for policyName in $attachedPolicies; do
        aws iam detach-role-policy --role-name "$roleName" --policy-name "$policyName"
    done

    # Detach inline policies
    inlinePolicies=$(aws iam list-role-policies --role-name "$roleName" --query 'PolicyNames' --output text)
    for inlinePolicy in $inlinePolicies; do
        aws iam delete-role-policy --role-name "$roleName" --policy-name "$inlinePolicy"
    done

    # Delete the IAM role
    aws iam delete-role --role-name "$roleName"
done

# Lambda Functions
aws lambda list-functions --query 'Functions[?contains(FunctionName, `sra`)].FunctionName' --output text | while read -r functionName; do
    aws lambda delete-function --function-name "$functionName"
done

# S3 Buckets
aws s3 ls | awk '$NF ~ /sra/ {print $NF}' | while read -r bucketName; do
    aws s3 rb "s3://$bucketName" --force
done
