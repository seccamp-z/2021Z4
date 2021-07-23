# Infrastructure

Terraform Manifest for seccamp2021-z4 student environment

## Specification

- versions:
  - terraform v1.0.3
  - aws cli v2

## Setup
(1) install terraform cli
```
mkdir -p /tmp/tf && cd $_
curl -O https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_darwin_amd64.zip
unzip terraform_1.0.3_darwin_amd64.zip
sudo mv terraform /usr/local/bin
```

(2) install aws cli (refere
[here](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-mac.html))

(3) preparation
```
cat <<EOF >> ~/.bashrc
export AWS_ACCESS_KEY_ID="XXX"
export AWS_SECRET_ACCESS_KEY="XXX"
complete -C '/usr/local/bin/aws_completer' aws
complete -C /usr/local/bin/terraform terraform
EOF
```

## Cheatsheet
```
aws ec2 describe-vpcs
aws ec2 describe-internet-gateways
aws ec2 describe-subnets
aws ec2 describe-security-groups
aws ec2 describe-instances
```
