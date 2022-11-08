apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sonar-ingress
  namespace: sonar-system
  annotations:
    cert-manager.io/cluster-issuer: sonar-system-letsencrypt-issuer
spec:
  tls:
    - hosts:
        - ${SONAR_URL_PREFIX}.${ROOT_URL}
      secretName: sonar-system-issuer-account-key
  rules:
    - host: ${SONAR_URL_PREFIX}.${ROOT_URL}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: sonar
                port:
                  number: 9000
