---
apiVersion: v1
kind: PersistentVolumeClaim # Create PVC
metadata:
  namespace: nexus-system
  name: nexus-data-claim # Sets name of PV
spec:
  accessModes:
    - ReadWriteOnce # Sets read and write access
  resources:
    requests:
      storage: 250Gi # Sets volume size
---
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: nexus-system
  name: nexus  # Sets Deployment name
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: nexus
#  securityContext:
#    runAsUser: 200
#    supplementalGroups:
#      - 200
#    fsGroup: 200
  template:
    metadata:
      labels:
        app: nexus
    spec:
      containers:
        - name: nexus
          image: sonatype/nexus3 # Sets Image
          imagePullPolicy: "IfNotPresent"
          ports:
            - containerPort: 8081  # Exposes container port
            - containerPort: 5000  # Exposes container port
          volumeMounts:
            - mountPath: /nexus-data
              name: nexus-data-volume
#          securityContext:
#            runAsUser: 200
#            fsGroup: 200
#            supplementalGroups:
#              - 200
          env:
            - name: NEXUS_CONTEXT
              value: "nexus"
            - name: INSTALL4J_ADD_VM_PARAMS
              value: "-Djava.util.prefs.userRoot=/nexus-data/app"
      volumes:
        - name: nexus-data-volume
          persistentVolumeClaim:
            claimName: nexus-data-claim
---
apiVersion: v1
kind: Service
metadata:
  namespace: nexus-system
  name: nexus # Sets service name
  labels:
    app: nexus # Labels and Selectors
spec:
  type: ClusterIP # Sets service type
  ports:
    - name: http
      port: 8081
      protocol: TCP
  selector:
    app: nexus
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-nexus-system-http-solver
  namespace: nexus-system
  annotations:
    argocd.argoproj.io/compare-options: IgnoreExtraneous
spec:
  rules:
    - host: solver.apps.${ROOT_URL}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: nexus-system-letsencrypt-issuer
  namespace: nexus-system
spec:
  acme:
    email: z.karahacane@actongroup.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: nexus-system-issuer-account-key
    solvers:
    - http01:
        ingress:
          name: ingress-nexus-system-http-solver
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nexus-ingress
  namespace: nexus-system
  annotations:
    cert-manager.io/cluster-issuer: nexus-system-letsencrypt-issuer
spec:
  tls:
    - hosts:
        - nexus-system-ingress.apps.${ROOT_URL}
      secretName: nexus-system-issuer-account-key
  rules:
    - host: nexus-system-ingress.apps.${ROOT_URL}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nexus
                port:
                  number: 8081
