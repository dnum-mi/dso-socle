name: openid_connect
label: Keycloak
args:
  name: openid_connect
  scope:
    - openid
    - profile
    - email
  response_type: code
  issuer: https://${KEYCLOAK_URL_PREFIX}.${ROOT_URL}/auth/realms/dso
  client_auth_method: query
  discovery: true
  uid_field: email
  client_options:
    identifier: gitlab-client
    secret: ${KEYCLOAK_GITLAB_SECRET_KEY}
    redirect_uri: https://${PORTAIL_URL_PREFIX}.${ROOT_URL}/users/auth/openid_connect/callback
