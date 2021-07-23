# Infrastructure

Terraform Manifest for seccamp2021-z4 student environment


## Design Specification / How to access server

- versions:
  - terraform v1.0.3
  - aws cli v2

```
ssh -l ubuntu -i /path/to/seccamp.pem 35.76.23.33
```

```
Host student01
  HostName 35.76.23.33
  User ubuntu
  IdentityFile ~/Desktop/seccamp.pem
  StrictHostKeyChecking no

Host student02
  HostName 18.181.158.4
  User ubuntu
  IdentityFile ~/Desktop/seccamp.pem
  StrictHostKeyChecking no

Host student03
  HostName 35.76.53.123
  User ubuntu
  IdentityFile ~/Desktop/seccamp.pem
  StrictHostKeyChecking no

Host student04
  HostName 18.179.159.74
  User ubuntu
  IdentityFile ~/Desktop/seccamp.pem
  StrictHostKeyChecking no
```

| server-name | student-name |
| ----------- | ------------ |
| student01   | xxx          |
| student02   | xxx          |
| student03   | xxx          |
| student04   | xxx          |

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
