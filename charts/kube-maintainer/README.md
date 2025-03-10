# kube-maintainer

A Helm chart for maintaining Kubernetes resources
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## About

This chart is a maintainer for Kubernetes

```console
## Add Helm repo
helm repo add k8s-utils https://rahu2000.github.io/charts/

## Install the kube-maintainer Helm chart
helm install kube-maintainer k8s-utils/kube-maintainer --namespace kube-maintainer
```

## How to K8s Resources Deploy

### Deploy
```
curl -X POST https://localhost:5000/maintainer/plugin/deploy \
     -H "Content-Type: application/json" \
     -d '{
           "config_category": "system-maintenance",
           "namespace": "backend",
           "auto_delete": "false",
           "sleep_time": "240",
           "services" : "your-server"
         }'
```

### delete
```
curl -X POST https://localhost:5000/maintainer/plugin/delete \
     -H "Content-Type: application/json" \
     -d '{
           "config_category": "system-maintenance",
           "namespace": "backend",
           "services" : "your-server"
         }'
```

## Uninstalling the Chart

To uninstall/delete the `kube-maintainer` chart:

```console
helm delete -n kube-maintainer kube-maintainer
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configMaps[0].data.host | string | `"your-domain.com"` |  |
| configMaps[0].data.responseBody | string | `"{\n  \"responseCode\": 401,\n  \"errorType\": \"SystemMaintenance\",\n  \"errorTarget\": \"AuthToken\",\n  \"errorReason\": \"Blank\",\n  \"errorCode\": 1201,\n  \"errorMessage\": \"Currently undergoing system maintenance\"\n}\n"` |  |
| configMaps[0].data.services[0] | string | `"your-service"` |  |
| configMaps[0].enabled | bool | `true` |  |
| configMaps[0].name | string | `"system-maintenance"` |  |
| extraEnv | list | `[]` |  |
| fullnameOverride | string | `nil` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"rahu2000/kube-maintainer"` |  |
| image.tag | string | `"0.1.0"` |  |
| ingress.enabled | bool | `false` |  |
| livenessProbe.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.httpGet.port | int | `5000` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| nameOverride | string | `nil` |  |
| namespace | string | `"kube-system"` |  |
| readinessProbe.httpGet.path | string | `"/healthz"` |  |
| readinessProbe.httpGet.port | int | `5000` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| replicas | int | `1` |  |
| resources.limits.cpu | string | `"500m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| targetNamespaces[0] | string | `"backend"` |  |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rahu2000 | <rahu2000@naver.com> | <https://github.com/Rahu2000> |
