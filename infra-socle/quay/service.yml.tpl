apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: quay-operator
  namespace: openshift-operators
spec:
  channel: stable-3.7
  installPlanApproval: Automatic
  name: quay-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: quay-operator.v3.7.8
---
apiVersion: v1
kind: Secret
metadata:
  name: ${SERVICE_NAME}-config-bundle
  generateName: ${SERVICE_NAME}-config-bundle-
  namespace: openshift-operators
type: Opaque
data:
  config.yaml: >-
    ${CONFIG_YAML}
---
kind: QuayRegistry
apiVersion: quay.redhat.com/v1
metadata:
  name: ${SERVICE_NAME}
  namespace: openshift-operators
spec:
  configBundleSecret: ${SERVICE_NAME}-config-bundle
  components:
    - kind: clair
      managed: true
      overrides:
        env:
          - name: IGNORE_VALIDATION
            value: "true"
   - kind: postgres
      managed: true
    - kind: objectstorage
      managed: true
    - kind: redis
      managed: true
    - kind: horizontalpodautoscaler
      managed: true
    - kind: route
      managed: true
    - kind: mirror
      managed: true
      overrides:
        env:
          - name: IGNORE_VALIDATION
            value: "true"
    - kind: monitoring
      managed: true
    - kind: tls
      managed: true
    - kind: quay
      managed: true
      overrides:
        env:
          - name: IGNORE_VALIDATION
            value: "true"
    - kind: clairpostgres
      managed: true
