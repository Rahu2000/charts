{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kube-maintainer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Namespace
*/}}
{{- define "kube-maintainer.namespace" -}}
{{- default (default .Release.Namespace "default") .Values.namespace -}}
{{- end -}}

{{/*
Service Account Name
*/}}
{{- define "kube-maintainer.serviceAccountName" -}}
{{- default (printf "%s-sa" (include "kube-maintainer.name" .)) .Values.serviceAccount.name -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kube-maintainer.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kube-maintainer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kube-maintainer.labels" -}}
{{ include "kube-maintainer.selectorLabels" . }}
{{- if ne .Release.Name "kustomize" }}
helm.sh/chart: {{ include "kube-maintainer.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
{{- end -}}

{{/*
Common selector labels
*/}}
{{- define "kube-maintainer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kube-maintainer.name" . }}
{{- if ne .Release.Name "kustomize" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end -}}