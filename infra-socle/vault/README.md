# Installation de VAULT

## Installation de vault via helm
```sh
install.sh
```

Ce script fait les opérations suivante:

oc delete namespace vault-system
oc apply -f create-namespace-vault.yaml
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm install vault hashicorp/vault  --set "global.openshift=true"  --set "server.route.enabled=true" --set "server.route.host=vault-route-vault-system.apps.${SUBDOMAIN}.${DOMAIN_NAME}" --set "serve
r.ha.enabled=false" --set "server.standalone.enabled=true"  --set "server.auditStorage.enable=true" --set "server.dataStorage.enable=true" --set "server.dataStorage.size=23Gi" -n vault-syst
em

## Creation de l'ingress, du clusterIssuer etc.

```
oc apply -f vault-cluster-issuer.yaml
oc apply -f vault-ingress.yaml
```

## Configurer Vault

### initialisation
Se connecter au pod et initialiser vault

kubectl exec -it vault-0 -n vault-system sh

```
vault operator init \
     -key-shares=3 \
     -key-threshold=2
```

Noter les 3 clés et le root token
```
vault operator unseal key1
vault operator unseal key2
```

Se connecter sur l'URL de l'ingres créée

Lors de l'initialisation du Vault choisir 1 root token et 1 part

Noter la Root token et le Seal token

### Configurer l'accès à gitlab

Dans Acces -> auth method -> Enable new Method
Choisir JWT et laisser le nom jwt puis dans configuration mettre l'URL de gitlab sans le / de fin, par exemple : https://gitlab-op.apps.${SUBDOMAIN}.${DOMAIN_NAME}


et préciser le Default role default-ci


Création du role default-ci
export VAULT_TOKEN=<ROOT_TOKEN>
```
vault write auth/jwt/role/default-ci - <<EOF
{
  "role_type": "jwt",
  "policies": ["default-ci"],
  "token_explicit_max_ttl": 60,
  "bound_claims_type": "glob",
  "user_claim": "user_email",
  "bound_claims": {
    "iss": "gitlab-op.apps.${SUBDOMAIN}.${DOMAIN_NAME}"
  },
  "claim_mappings": {
    "namespace_path": "namespace_path",
    "project_path": "project_path",
    "project_id": "project_id",
    "ref": "ref"
  }
}
EOF
```
creation de la policy default-ci

Récupération de l'accessor de la méthode JWT, par exemple auth_jwt_73123690 et adapter :
```
vault policy write default-ci - <<EOF
path "forge-dso/+/{{identity.entity.aliases.auth_jwt_73123690.metadata.namespace_path}}/*" {
   capabilities = ["list","read"]
}
path "forge-dso/+/{{identity.entity.aliases.auth_jwt_73123690.metadata.namespace_path}}" {
   capabilities = ["list","read"]
}
EOF

creation du secret engine kv avec pour nom forge-dso

```
