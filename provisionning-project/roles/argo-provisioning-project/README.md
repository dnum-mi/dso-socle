# argo-provisioning-project

This role creates ArgoCD-operator-based `AppProject` objects.

## Usage

```yaml
- hosts: localhost
  become: false
  gather_facts: false

  roles:
  - role: argo-provisioning-project

  vars:
    ENV_LIST:
    - dev
    - staging
    - production

    GITLAB_USER: myminion
    GITLAB_TOKEN: glpat-v2hPsNobbR8v2s189b2F

    GITLAB_URL: https://gitlab.myorg.com
    GITLAB_PROJECT_PATH: "{{ GITLAB_URL }}/myorg/myproject/mygitops.git"

    NAMESPACE_NAME: my-project

    # Use existing kubeconfig
    override_kubeconfig: false # Default value, use 'true' at your own risk
    K8S_AUTH_KUBECONFIG: {}
```