apiVersion: keycloak.org/v1alpha1
kind: KeycloakClient
metadata:
  name: quay-client
  labels:
    app: sso
  namespace: keycloak-system
spec:
  client:
    clientId: quay-client
    secret: ${KEYCLOACK_QUAY_SECRET}
    clientAuthenticatorType: client-secret
    standardFlowEnabled: true
    redirectUris:
      - https://${QUAY_URL_PREFIX}.${ROOT_URL}/oauth2/keycloak/callback/attach
      - https://${QUAY_URL_PREFIX}.${ROOT_URL}/oauth2/keycloak/callback/cli
      - https://${QUAY_URL_PREFIX}.${ROOT_URL}/oauth2/keycloak/callback
    webOrigins:
      - https://${QUAY_URL_PREFIX}.${ROOT_URL}
    defaultClientScopes:
      - profile
      - email
  realmSelector:
    matchLabels:
      app: sso
