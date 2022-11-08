pip3 install gitlab requests python-gitlab kubernetes

ansible-playbook -i inventory/dev/ ./init-gitlab.yaml --vault-password-file /app/vault-secret --connection=local -e 'ansible_python_interpreter=/usr/bin/python3'
