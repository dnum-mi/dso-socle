export $(cat var.env |xargs)

kubectl -n=sonar-system delete  secret dso-postgres-secret 2> /dev/null
kubectl -n sonar-system \
         create secret generic dso-postgres-secret \
          --from-literal="POSTGRES_ADMIN_USER=$POSTGRES_ADMIN_USER" \
           --from-literal="POSTGRES_ADMIN_PASSWORD=$POSTGRES_ADMIN_PASSWORD"


echo "SECRET POSTGRES"

echo "added  POSTGRES_ADMIN_USER=$POSTGRES_ADMIN_USER"
echo "added  POSTGRES_ADMIN_PASSWORD=$POSTGRES_ADMIN_PASSWORD"
