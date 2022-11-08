ansible-playbook -i inventory/dev/ ./init-ldap.yaml --vault-password-file /app/vault-secret --connection=local -e 'ansible_python_interpreter=/usr/bin/python3'
