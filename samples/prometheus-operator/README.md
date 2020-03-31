# Install Prometheus Operator Helm chart

Install the prometheus operator helm chart with thanos sidecar and custom
values.

## Create thanos storage

check storage information with:

```hcl
terraform output thanos_storage_config
```

with the output of the last command create the ```/tmp/thanos-config.yaml```

## Install Helm chart

```bash
kubectl create ns monitoring
kubectl -n monitoring create secret generic thanos-objstore-config --from-file=thanos.yaml=/tmp/thanos-config.yaml

helm install --namespace monitoring --name monit -f custom-values.yaml stable/prometheus-operator
```

when everything is done check installation:

```bash
kubectl get pods -n monitoring
kubectl get svc -n monitoring
```

## Uninstall Helm chart

```bash
helm delete monit --purge
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com

kubectl delete secret thanos-objstore-config -n monitoring
kubectl delete ns monitoring
```

## References

- https://github.com/helm/charts/tree/master/stable/prometheus-operator
- https://github.com/coreos/prometheus-operator/blob/master/Documentation/thanos.md
- https://www.digitalocean.com/community/tutorials/how-to-set-up-digitalocean-kubernetes-cluster-monitoring-with-helm-and-prometheus-operator
