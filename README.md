# Deployment Instance

Creates an EC2 instance in us-east-1 for deployment purposes with CORP network access.

## Usage

```bash
./deploy.sh [aws-profile]
```

Uses AWS_PROFILE environment variable if no profile specified.

## Features

- Uses local public key via cloud-config
- Creates "default" user with sudo access
- Automatically detects if running on Amazon VPN
- Adds current IP to security group if not on VPN
- Uses a specific network prefix list for access
- Fedora 42 Cloud Base with git and AWS CLI pre-installed

## Requirements

- AWS CLI configured with appropriate permissions
