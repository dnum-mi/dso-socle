apiVersion: apps.gitlab.com/v1beta2
kind: Runner
metadata:
  name: gitlab-runner
  namespace: gitlab-system
spec:
  gitlabUrl: https://${GITLAB_URL_PREFIX}.${ROOT_URL}/
  runUntagged: true
  buildImage: alpine
  token: gitlab-runner-secret
  tags: openshift
  env: custom-env
  #config: custom-config-toml

