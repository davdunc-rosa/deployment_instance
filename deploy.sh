#!/bin/bash

STACK_NAME="deployment-instance"
REGION="us-east-1"

# Check if on Amazon VPN by testing connectivity to internal resource
if curl -s --connect-timeout 5 http://169.254.169.254/latest/meta-data/ > /dev/null 2>&1; then
    echo "Detected Amazon environment - skipping IP detection"
    CURRENT_IP=""
else
    echo "Getting current IP address..."
    CURRENT_IP=$(curl -s https://checkip.amazonaws.com)
    if [ -z "$CURRENT_IP" ]; then
        echo "Failed to get current IP address"
        exit 1
    fi
    echo "Current IP: $CURRENT_IP"
fi

# Read cloud-config content
CLOUD_CONFIG=$(cat cloud-config.yaml)

# Deploy CloudFormation stack
echo "Deploying CloudFormation stack..."
aws cloudformation deploy \
    --template-file template.yaml \
    --stack-name "$STACK_NAME" \
    --region "$REGION" \
    --parameter-overrides \
        CurrentIP="$CURRENT_IP" \
        CloudConfigContent="$CLOUD_CONFIG" \
    --capabilities CAPABILITY_IAM

if [ $? -eq 0 ]; then
    echo "Stack deployed successfully!"
    aws cloudformation describe-stacks \
        --stack-name "$STACK_NAME" \
        --region "$REGION" \
        --query 'Stacks[0].Outputs'
else
    echo "Stack deployment failed!"
    exit 1
fi
