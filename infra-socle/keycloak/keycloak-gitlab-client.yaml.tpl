apiVersion: keycloak.org/v1alpha1
kind: KeycloakClient
metadata:
  name: gitlab-client
  labels:
    app: sso
  namespace: keycloak-system
spec:
  client:
    clientId: gitlab-client
    secret: ${GITLAB_CLIENT_SECRET}
    clientAuthenticatorType: client-secret
    standardFlowEnabled: true
    redirectUris:
      - https://${GITLAB_URL_PREFIX}.${ROOT_URL}/users/auth/openid_connect/callback
    webOrigins:
      - https://${GITLAB_URL_PREFIX}.${ROOT_URL}
    defaultClientScopes:
      - profile
      - email
  realmSelector:
    matchLabels:
      app: sso
