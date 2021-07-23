# Infrastructure

Terraform Manifest for seccamp2021-z4 student environment

## How to access server

```
ssh -o ProxyCommand='ssh -i ~/.ssh/hoge.pem -W %h:%p ec2-user@x.x.x.x' ubuntu@10.1.0.a
```

## Design Specification

- versions:
  - terraform v1.0.3
  - aws cli v2

```
+----+
+----+
```

| server-name | server-ip | student-name |
| ----------- | --------- | ------------ |
| student1    | 10.1.0.a  | xxx          |
| student2    | 10.1.0.a  | xxx          |
| student3    | 10.1.0.a  | xxx          |
| student4    | 10.1.0.a  | xxx          |

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
