apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-sonar-system-http-solver
  namespace: sonar-system
  annotations:
    argocd.argoproj.io/compare-options: IgnoreExtraneous
spec:
  rules:
    - host: solver.apps.${ROOT_URL}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: sonar-system-letsencrypt-issuer
  namespace: sonar-system
spec:
  acme:
    email: p.leclainche@actongroup.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: sonar-system-issuer-account-key
    solvers:
    - http01:
        ingress:
          name: ingress-sonar-system-http-solver
