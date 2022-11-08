apiVersion: keycloak.org/v1alpha1
kind: KeycloakClient
metadata:
  name: sonar-client
  labels:
    app: sso
  namespace: keycloak-system
spec:
  client:
    clientId: sonar-client
    secret: ${KEYCLOACK_SONAR_SECRET}
    clientAuthenticatorType: client-secret
    standardFlowEnabled: true
    redirectUris:
      - https://${SONAR_URL_PREFIX}.${ROOT_URL}/auth/callback
    webOrigins:
      - https://${SONAR_URL_PREFIX}.${ROOT_URL}
    defaultClientScopes:
      - profile
      - email
      - groups
  realmSelector:
    matchLabels:
      app: sso
