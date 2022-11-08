#!/bin/bash


echo "Post install"
ansible-playbook -i init/inventory/dev/ ./init/init-ldap.yaml --vault-password-file /app/vault-secret --connection=local -e 'ansible_python_interpreter=/usr/bin/python3'

