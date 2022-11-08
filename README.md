# infra-dso-socle

## Création de namespace
```shell
ansible-playbook ./provisioning-openshift.yml -i /inventory/dev -e "{\"ORGANIZATION_NAME\":\"test\",\"PROJECT_NAME\":\"test-env-project\",\"K8S_PERMISSION_LEVEL\":\"edit\",\"ENV_LIST\":['dev', 'staging', 'integration', 'prod'],\"EMAIL\":\"toto@test.com\"}" --connection=local --vault-password-file /app/vault-secret
```


## Provisioning de projets

```shell
ansible-playbook ./provisioning-project-dso.yml -i inventory/dev \
-e "{\"REPO_NAME\": \"test-env\",\"ORGANIZATION_NAME\": \"test\",\"EMAIL\": \"toto@test.com\",\"PROJECT_NAME\": \"test-env-project\",\"ENV_LIST\":['dev', 'staging', 'integration', 'prod']}" --vault-password-file /app/vault-secret --connection=local 
```

## Notes

***The following packages must be installed on the Ansible machine, before launching the gitlab playbooks***

```yaml
name: Ensure Python3 Packages are already installed
      become: yes
      ansible.builtin.package:
        name:
          - python3-gitlab
        state: present
```
