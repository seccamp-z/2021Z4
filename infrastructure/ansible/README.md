
## Setup

```
vim /opt/seccamp.pem #admin-info
```

```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
source ~/.bash_profile
pyenv install 3.8.0
pyenv global 3.8.0
pip install pipenv
pipenv sync
pipenv run ansible-playbook -i hosts.yaml main.yaml
```

```
$ aws ec2 describe-network-interfaces | jq .NetworkInterfaces[].Association.PublicIp -r
54.64.182.241
54.238.97.165
54.248.155.91
35.75.183.22
```
