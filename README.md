# Deployment Instance

Creates an EC2 instance in us-east-1 for deployment purposes with CORP network access.

## Usage

```bash
./deploy.sh
```

## Features

- Uses local public key via cloud-config
- Creates "davdunc" user with sudo access
- Automatically detects if running on Amazon VPN
- Adds current IP to security group if not on VPN
- Uses AAPL CORP network prefix list for access
- Amazon Linux 2023 with git and AWS CLI pre-installed

## Requirements

- AWS CLI configured with appropriate permissions
