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
