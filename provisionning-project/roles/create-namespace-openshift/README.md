# create-namespace-openshift

Thes role creates a k8s namespace and sets a secret to access Quay.

## Usage

```yaml
- hosts: localhost
  become: false
  gather_facts: false
  roles:
  - role: create-namespace-openshift

  vars:
    ENV_LIST:
    - dev
    - staging
    - production

    ORGANIZATION_NAME: myorg
    PROJECT_NAME: myproject

    K8S_AUTH_KUBECONFIG: {} # Used to override the default kubeconfig
```
