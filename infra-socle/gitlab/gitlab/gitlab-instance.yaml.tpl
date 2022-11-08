apiVersion: apps.gitlab.com/v1beta1
kind: GitLab
metadata:
  name: gitlab
  namespace: gitlab-system
spec:
  chart:
    values:
      certmanager:
        install: true
      global:
        hosts:
          domain: ${SUBDOM_URL}.${ROOT_URL}
          gitlab:
            name: gitlab-op${SUBDOM_URL}.${ROOT_URL}
          registry:
            name: gitlab-registry${SUBDOM_URL}.${ROOT_URL}
          minio:
            name: gitlab-minio${SUBDOM_URL}.${ROOT_URL}
          smartcard:
            name: gitlab-smartcard${SUBDOM_URL}.${ROOT_URL}
          kas:
            name: gitlab-kas${SUBDOM_URL}.${ROOT_URL}
          pages:
            name: gitlab-pages${SUBDOM_URL}.${ROOT_URL}
        ingress:
          configureCertmanager: true
          class: none
        extraEnv:
          HTTP_PROXY: ${PROXY_DSO}
          HTTPS_PROXY: ${PROXY_DSO}
          NO_PROXY: ${NO_PROXY_DSO}
        appConfig:
          ldap:
            preventSignin: true
          omniauth:
            enabled: true
            syncProfileAttributes: ["email"]
            allowSingleSignOn: ["openid_connect"]
            blockAutoCreatedUsers: false
            autoSignInWithProvider: "openid_connect"
            autoLinkLdapUser: false
            autoLinkSamlUser: false
            autoLinkUser: ["openid_connect"]
            providers:
              - secret: openid-connect
    version: 6.2.2
