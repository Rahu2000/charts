# {{/* vim: set filetype=mustache: */}}
# {{/* Expand the name of the chart. */}}
# {{- define "additionalAnnotations" -}}
# {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
# {{- end -}}

# additionalLabels

# namespace

# finalizers
{{- define "finalizers" }}
finalizers:
  - resources-finalizer.argocd.argoproj.io
{{- end }}

# project

# repoUrl
{{- define "awsLoadBalancerController.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.awsLoadBalancerController.repoUrl }}
repoUrl: {{ .Values.applications.awsLoadBalancerController.repoUrl }}
{{- else }}
repoUrl: "https://aws.github.io/eks-charts"
{{- end }}
{{- end }}

# source
{{- define "awsLoadBalancerController.source" }}
{{- include "awsLoadBalancerController.repoUrl" .}}
chart: "aws-load-balancer-controller"
targetRevision: {{ .Values.applications.awsLoadBalancerController.chartVersion | default "HEAD" }}
{{- end }}

# sources

# destination

{{- define "destination" }}
{{- if .Values.global.destination }}
destination:
  server: {{ .Values.global.destination.server }}
  namespace: {{ .Values.global.destination.namespace }}
{{- else }}
destination:
  server: "https://kubernetes.default.svc"
  namespace: "default"
{{- end }}
{{- end }}
# syncPolicy

# revisionHistoryLimit

# ignoreDifferences

# info
