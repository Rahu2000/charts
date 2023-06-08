{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "kyverno-additional-policies.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "kyverno-additional-policies.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Helm required labels */}}
{{- define "kyverno-additional-policies.labels" -}}
app.kubernetes.io/component: kyverno
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ template "kyverno-additional-policies.name" . }}
app.kubernetes.io/part-of: {{ template "kyverno-additional-policies.name" . }}
app.kubernetes.io/version: "{{ .Chart.Version | replace "+" "_" }}"
helm.sh/chart: {{ template "kyverno-additional-policies.chart" . }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
{{- end -}}

{{/* Set if a BestPractices policy is managed */}}
{{- define "kyverno-additional-policies.podSecurityBestPractices" -}}
{{- if ne .Values.podSecurityPolicyCategory "custom" }}
{{- true }}
{{- else if and (eq .Values.podSecurityPolicyCategory "custom") (has .name .Values.podSecurityPolicies) }}
{{- true }}
{{- else -}}
{{- false }}
{{- end -}}
{{- end -}}

{{/* Set if a recommended policy is managed */}}
{{- define "kyverno-additional-policies.podSecurityRecommend" -}}
{{- if eq .Values.podSecurityPolicyCategory "recommend" }}
{{- true }}
{{- else if and (eq .Values.podSecurityPolicyCategory "custom") (has .name .Values.podSecurityPolicies) }}
{{- true }}
{{- else if has .name .Values.includeRecommendedPolicies }}
{{- true }}
{{- else -}}
{{- false }}
{{- end -}}
{{- end -}}

{{/* Set if a AWS policy is managed */}}
{{- define "kyverno-additional-policies.podSecurityOnAws" -}}
{{- if eq .Values.podSecurityPolicyCategory "aws" }}
{{- true }}
{{- else if and (eq .Values.podSecurityPolicyCategory "custom") (has .name .Values.podSecurityPolicies) }}
{{- true }}
{{- else if has .name .Values.includeAWSPolicies }}
{{- true }}
{{- else -}}
{{- false }}
{{- end -}}
{{- end -}}


{{/* Set if a Ingress Nginx policy is managed */}}
{{- define "kyverno-additional-policies.podSecurityOnNginx" -}}
{{- if eq .Values.podSecurityPolicyCategory "nginx" }}
{{- true }}
{{- else if and (eq .Values.podSecurityPolicyCategory "custom") (has .name .Values.podSecurityPolicies) }}
{{- true }}
{{- else if has .name .Values.includeNginxPolicies }}
{{- true }}
{{- else -}}
{{- false }}
{{- end -}}
{{- end -}}

{{/* Set if a ArgoCD policy is managed */}}
{{- define "kyverno-additional-policies.podSecurityOnArgo" -}}
{{- if eq .Values.podSecurityPolicyCategory "argo" }}
{{- true }}
{{- else if and (eq .Values.podSecurityPolicyCategory "custom") (has .name .Values.podSecurityPolicies) }}
{{- true }}
{{- else if has .name .Values.includeArgoPolicies }}
{{- true }}
{{- else -}}
{{- false }}
{{- end -}}
{{- end -}}

{{/* Get deployed Kyverno version from Kubernetes */}}
{{- define "kyverno-additional-policies.kyvernoVersion" -}}
{{- $version := "" -}}
{{- if eq .Values.kyvernoVersion "autodetect" }}
{{- with (lookup "apps/v1" "Deployment" .Release.Namespace "kyverno") -}}
  {{- with (first .spec.template.spec.containers) -}}
    {{- $imageTag := (last (splitList ":" .image)) -}}
    {{- $version = trimPrefix "v" $imageTag -}}
  {{- end -}}
{{- end -}}
{{ $version }}
{{- else -}}
{{ .Values.kyvernoVersion }}
{{- end -}}
{{- end -}}

{{/* Fail if deployed Kyverno does not match */}}
{{- define "kyverno-additional-policies.supportedKyvernoCheck" -}}
{{- $supportedKyverno := index . "ver" -}}
{{- $top := index . "top" }}
{{- if (include "kyverno-additional-policies.kyvernoVersion" $top) -}}
  {{- if not ( semverCompare $supportedKyverno (include "kyverno-additional-policies.kyvernoVersion" $top) ) -}}
    {{- fail (printf "Kyverno version is too low, expected %s" $supportedKyverno) -}}
  {{- end -}}
{{- end -}}
{{- end -}}
