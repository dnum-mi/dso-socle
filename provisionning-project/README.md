# Scripts Ansible pour gérer les projets


## Creation de l'arborescence gitlab pour un projet provisioning-project-dso.yml

Playbook Ansible d'initialisation d'un projet :
 * Creation des groupes / sous groupe dans gitlab
 * Creation des projets dans Quay, Nexus, Sonar, etc.
 * Creation de l'utilisateur

```
ansible-playbook provisioning-project-dso.yml -i inventory/dev/ \
-e "ORGANIZATION_NAME=interieur" -e "EMAIL=toto@example.com" -e "PROJECT_NAME=inittest" \
--connection=local --vault-password-file /app/vault-secret
```



## Import d'un projet depuis un repo externe

Importer un repo de source d'un projet par exemple github vers la froge DSO

```
ansible-playbook import_git_project.yml -i inventory/dev \
-e "ORGANIZATION_NAME=interieur" \
-e "EMAIL=toto@example.com" \
-e "REPO_SRC=github.com/test/test.git" \
-e "REPO_DEST=inittest" \
-e "PROJECT_NAME=inittest" \
-e "GIT_INPUT_USER=INPUTUSER" \
--connection=local --vault-password-file /app/vault-secret
```

## provisioning-user.yml

Ajout d'un utilisateur à un projet gitlab existant



