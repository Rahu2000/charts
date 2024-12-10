# Argo Gitops

## About

This chart contains Kyverno's implementation of the Kubernetes policies as documented at https://kyverno.io/policies/pod-security/ and are a Helm packaged version of those found at https://github.com/Rahu2000/charts/tree/main/charts/kyverno.

The following policies are included in each profile.

## Installing the Chart

These chart have a minimum requirement of ArgoCD 2.6.0.

```console
## Add Helm repo
helm repo add k8s-devops https://rahu2000.github.io/charts/

## Install the Kyverno additional policies Helm chart
helm install argo-gitops k8s-devops/argo-gitops --namespace argocd
```

## Uninstalling the Chart

To uninstall/delete the `argo-gitops` chart:

```console
helm delete -n argo-gitops argo-gitops
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Values

| Key    | Type   | Default | Description |
| ------ | ------ | ------- | ----------- |
| global | object | `{}`    |             |

## Source Code

## Requirements

Kubernetes: `>=1.16.0-0`

## Maintainers

| Name     | Email                | Url                           |
| -------- | -------------------- | ----------------------------- |
| rahu2000 | <rahu2000@naver.com> | <https://github.com/Rahu2000> |
