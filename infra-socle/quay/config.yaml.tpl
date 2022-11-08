AUTHENTICATION_TYPE: LDAP
FEATURE_DIRECT_LOGIN: false

JWT_AUTH_ISSUER: https://keycloak-keycloak-system.apps.${ROOT_URL}/auth/realms/dso/.well-known/openid-configuration                                                  
KEYCLOAK_LOGIN_CONFIG:
  CLIENT_ID: ${SERVICE_NAME}-client
  CLIENT_SECRET: ${CLIENT_SECRET}
  LOGIN_BINDING_FIELD: email
  LOGIN_SCOPES:
  - openid
  - email
  - profile
  OIDC_SERVER: https://keycloak-keycloak-system.apps.${ROOT_URL}/auth/realms/dso/
  PREFERRED_USERNAME_CLAIM_NAME: preferred_username
  SERVICE_NAME: SSO
  VERIFIED_EMAIL_CLAIM_NAME: email
LDAP_ADMIN_DN: cn=admin,dc=example,dc=org
LDAP_ADMIN_PASSWD: rootroot
LDAP_ALLOW_INSECURE_FALLBACK: false
LDAP_BASE_DN:
  - dc=example
  - dc=org
LDAP_EMAIL_ATTR: mail
LDAP_UID_ATTR: uid
LDAP_URI: ldap://openldap:1389
LDAP_USER_FILTER: ""
LDAP_USER_RDN:
  - ou=users
SERVER_HOSTNAME: ${SERVICE_NAME}.apps.${ROOT_URL}
SUPER_USERS:
  - admin
