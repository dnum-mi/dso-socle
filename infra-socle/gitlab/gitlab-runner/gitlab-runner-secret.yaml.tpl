apiVersion: v1
kind: Secret
metadata:
  name: gitlab-runner-secret
  namespace: gitlab-system
type: Opaque
stringData:
  runner-registration-token: "${GITLAB_REGISTRATION_TOKEN}" # your project runner secret

