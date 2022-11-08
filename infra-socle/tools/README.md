# Tools for DSO

## copy-kube-secret.sh

Ce script permet de copier un secret d'un namespace à un autre (il n'est pas possible de lire un secret depuis un autre namespace).

usage
```
copy-kube-secret.sh <nom du secret> <nom du namespace> <nom du namespace de destination>
```

Le script récupère le secret et le recopie dans le namespace de destination : kubectl apply -f -

## generate-ingress.sh

Generation des ingress et du clusterissuer associé pour générer 

usage
```
generate-ingress.sh <INGRESS_NAME> <INGRESS_NAMESPACE> <INGRESS_HOSTNAME>
```

Le script génrère un fichier <INGRESS_NAME>-ingress.yaml contenant le répertoire output. Ce fichier sera a adapter notamment pour les règles de redirection PathPrefix
