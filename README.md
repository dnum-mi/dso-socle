# infra-dso-socle

## Création de namespace
```shell
ansible-playbook ./provisionning-project/provisioning-openshift.yml \
  -i /inventory/dev \
  --connection=local \
  --vault-password-file /app/vault-secret \
  -e ORGANIZATION_NAME=test \
  -e PROJECT_NAME=test-env-project \
  -e K8S_PERMISSION_LEVEL=edit \
  -e EMAIL=toto@test.com \
  -e "{\"ENV_LIST\":\"['dev', 'staging', 'integration', 'prod']\"}"
```


## Provisioning de projets

```shell
ansible-playbook ./provisionning-project/provisioning-project-dso.yml \
  -i inventory/dev \
  --vault-password-file /app/vault-secret \
  --connection=local \
  -e REPO_NAME=test-env \
  -e ORGANIZATION_NAME=test \
  -e EMAIL=toto@test.com \
  -e PROJECT_NAME=test-env-project \
  -e "{\"ENV_LIST\":\"['dev', 'staging', 'integration', 'prod']\"}"
```

## Notes

***The following packages must be installed on the Ansible machine, before launching the gitlab playbooks***

```yaml
- name: Ensure Python3 Packages are already installed
  become: yes
  ansible.builtin.package:
    state: present
    name:
    - python3-gitlab
```
