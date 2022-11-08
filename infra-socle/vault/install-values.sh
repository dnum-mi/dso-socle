oc delete namespace vault-system
oc apply -f create-namespace-vault.yaml
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm install -f values.yaml vault hashicorp/vault -n vault-system
