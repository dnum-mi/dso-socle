# infra-dso-socle

## Usage

```bash
# Get the help message
make help
backoffice           Creates the backoffite resources of the console
dev-prepare          Set pre-commit configuration
help                 This help message
namespace            Creates a namespace and a user
```

```bash
# Set common variables
export INVENTORY=inventory/dev
export ORGANIZATION_NAME=test
export K8S_PERMISSION_LEVEL=edit
export EMAIL=toto@test.com
export ENV_LIST="{\"ENV_LIST\":\"['dev', 'staging', 'integration', 'prod']\"}"

# Set the project's name
export PROJECT_NAME=test-env-project
make namespace

# Creates the given repository
export REPO_NAME=my-repo
make repository
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
