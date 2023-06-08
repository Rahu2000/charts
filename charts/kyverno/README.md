# kyverno

Custom Kubernetes Pod Security implemented as Kyverno policies

![Version: v0.1.1](https://img.shields.io/badge/Version-v0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.10.3](https://img.shields.io/badge/AppVersion-v1.10.3-informational?style=flat-square)

## About

This chart contains Kyverno's implementation of the Kubernetes policies as documented at https://kyverno.io/policies/pod-security/ and are a Helm packaged version of those found at https://github.com/Rahu2000/charts/tree/main/charts/kyverno.

The following policies are included in each profile.

**Best Practices**

* check-deprecated-apis
* disable-automount-serviceaccount-token
* disable-service-discovery
* disallow-all-probes-equals
* disallow-container-sock-mounts
* disallow-default-namespace
* disallow-delete-kyverno
* disallow-empty-ingress-host
* disallow-latest-tag
* disallow-secrets-from-env-vars
* require-read-only-rootfs
* restrict-binding-clusteradmin
* restrict-deprecated-registry

**Recommend**

* add-default-containers-securitycontext
* add-default-pod-securitycontext
* add-default-topologyspreadconstraints
* add-namespace-quota
* allowed-image-repos
* block-ephemeral-containers
* check-emptydir-requests-limits
* check-memory-requests-equals-limits
* check-require-pod-probes
* check-required-labels
* check-vulnerable-kernel

**AWS**

* add-karpenter-donot-evict
* add-karpenter-nodeselector

**NGINX ingress**

* disallow-ingress-nginx-custom-snippets
* restrict-ingress-annotations
* restrict-ingress-paths

**Argo**

* check-application-field
* check-applicationset-name-matches-project
* check-appproject-clusterresourceblacklist
* disallow-default-project
* disallow-update-project

For the latest version of these policies, always refer to the kyverno/policies repo at https://github.com/kyverno/policies/tree/main/pod-security.

## Installing the Chart

These additional policies presently have a minimum requirement of Kyverno 1.6.0.

```console
## Add Helm repo
helm repo add k8s-policies https://rahu2000.github.io/charts/

## Install the Kyverno additional policies Helm chart
helm install kyverno-additional-policies k8s-policies/kyverno --namespace kyverno
```

## Uninstalling the Chart

To uninstall/delete the `kyverno-additional-policies` chart:

```console
helm delete -n kyverno kyverno-additional-policies
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autogenControllers | string | `""` | Customize the target Pod controllers for the auto-generated rules. (Eg. `none`, `Deployment`, `DaemonSet,Deployment,StatefulSet`) For more info https://kyverno.io/docs/writing-policies/autogen/. |
| background | bool | `true` | Policies background mode |
| customLabels | object | `{}` | Additional labels. |
| failurePolicy | string | `"Fail"` | API server behavior if the webhook fails to respond ('Ignore', 'Fail') For more info: https://kyverno.io/docs/writing-policies/policy-settings/ |
| generateExistingOnPolicyUpdate | bool | `true` |  |
| generateSynchronize | bool | `true` |  |
| generateSynchronizeByPolicy | object | `{}` | Define generateSynchronizeByPolicy for specific policies. Override the defined `generateSynchronize` with a individual generateSynchronize for individual Policies. |
| includeAWSPolicies | list | `[]` | Additional policies to include from `aws`. |
| includeArgoPolicies | list | `[]` | Additional policies to include from `argo`. |
| includeNginxPolicies | list | `[]` | Additional policies to include from `nginx`. |
| includeRecommendedPolicies | list | `[]` | Additional policies to include from `recommend`. |
| kyvernoVersion | string | `"autodetect"` | Kyverno version The default of "autodetect" will try to determine the currently installed version from the deployment |
| nameOverride | string | `nil` | Name override. |
| podSecurityPolicies | list | `[]` | Policies to include when `podSecurityPolicyCategory` is `custom`. |
| podSecurityPolicyCategory | string | `"bestpractices"` | Pod Security Policy Category profile (`aws`, `bestpractices`). For more info https://kyverno.io/policies/pod-security. |
| podSecuritySeverity | string | `"medium"` | Pod Security Standard (`low`, `medium`, `high`). |
| policyExclude | object | `{}` | Exclude resources from individual policies. Policies with multiple rules can have individual rules excluded by using the name of the rule as the key in the `policyExclude` map. |
| policyOverrides | object | `{}` |  |
| policyPreconditions | object | `{}` | Add preconditions to individual policies. Policies with multiple rules can have individual rules excluded by using the name of the rule as the key in the `policyPreconditions` map. |
| validationFailureAction | string | `"Audit"` | Validation failure action (`audit`, `enforce`, `Audit`, `Enforce`). For more info https://kyverno.io/docs/writing-policies/validate. |
| validationFailureActionByPolicy | object | `{}` | Define validationFailureActionByPolicy for specific policies. Override the defined `validationFailureAction` with a individual validationFailureAction for individual Policies. |
| validationFailureActionOverrides | object | `{"all":[]}` | Define validationFailureActionOverrides for specific policies. The overrides for `all` will apply to all policies. |

## Source Code

* <https://github.com/kyverno/policies>

## Requirements

Kubernetes: `>=1.16.0-0`

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rahu2000 | <rahu2000@naver.com> | <https://github.com/Rahu2000> |
