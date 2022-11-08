apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingressvault-http-solver
  namespace: vault-system
  annotations:
    argocd.argoproj.io/compare-options: IgnoreExtraneous
spec:
  rules:
    - host: solver.apps.${ROOT_URL}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: vault-system-letsencrypt-issuer
  namespace: vault-system
spec:
  acme:
    email: p.leclainche@actongroup.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: vault-system-issuer-account-key
    solvers:
    - http01:
        ingress:
          name: ingressvault-http-solver
