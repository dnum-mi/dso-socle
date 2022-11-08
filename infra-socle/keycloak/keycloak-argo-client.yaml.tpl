apiVersion: keycloak.org/v1alpha1
kind: KeycloakClient
metadata:
  name: argo-client
  labels:
    app: sso
  namespace: keycloak-system
spec:
  client:
    clientId: argo-client
    secret: ${KEYCLOACK_ARGO_SECRET}
    clientAuthenticatorType: client-secret
    standardFlowEnabled: true
    redirectUris:
      - https://${ARGOCD_URL_PREFIX}.${ROOT_URL}/auth/callback
    webOrigins:
      - https://${ARGOCD_URL_PREFIX}.${ROOT_URL}
    defaultClientScopes:
      - profile
      - email
      - groups
  realmSelector:
    matchLabels:
      app: sso
