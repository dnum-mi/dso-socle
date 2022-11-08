apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: vault-ingress
  namespace: vault-system
  annotations:
    cert-manager.io/cluster-issuer: vault-system-letsencrypt-issuer
spec:
  tls:
    - hosts:
        - ${VAULT_URL_PREFIX}.${ROOT_URL}
      secretName: vault-system-issuer-account-key
  rules:
    - host: ${VAULT_URL_PREFIX}.${ROOT_URL}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: vault
                port:
                  number: 8200
