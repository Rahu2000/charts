# {{/* vim: set filetype=mustache: */}}
# {{/* Expand the name of the chart. */}}

# finalizers
{{- define "finalizers" }}
finalizers:
  - resources-finalizer.argocd.argoproj.io
{{- end }}

# {{/* Applications repoUrl */}}
# aws-locad-balancer-controller
{{- define "awsLoadBalancerController.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.awsLoadBalancerController.repoUrl }}
repoUrl: {{ .Values.applications.awsLoadBalancerController.repoUrl }}
{{- else }}
repoUrl: "https://aws.github.io/eks-charts"
{{- end }}
{{- end }}

# aws-efs-csi-driver
{{- define "awsEfsCsiDriver.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.awsEfsCsiDriver.repoUrl }}
repoUrl: {{ .Values.applications.awsEfsCsiDriver.repoUrl }}
{{- else }}
repoUrl: "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
{{- end }}
{{- end }}

# cert-manager
{{- define "certManager.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.certManager.repoUrl }}
repoUrl: {{ .Values.applications.certManager.repoUrl }}
{{- else }}
repoUrl: "https://charts.jetstack.io"
{{- end }}
{{- end }}

# cluster-autoscaler
{{- define "clusterAutoscaler.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.clusterAutoscaler.repoUrl }}
repoUrl: {{ .Values.applications.clusterAutoscaler.repoUrl }}
{{- else }}
repoUrl: "https://kubernetes.github.io/autoscaler"
{{- end }}
{{- end }}

# external-dns
{{- define "externalDns.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.externalDns.repoUrl }}
repoUrl: {{ .Values.applications.externalDns.repoUrl }}
{{- else }}
repoUrl: "https://kubernetes-sigs.github.io/external-dns"
{{- end }}
{{- end }}

# metrics-server
{{- define "metricsServer.repoUrl" }}
{{- if .Values.global.repoUrl }}
repoUrl: {{ .Values.global.repoUrl }}
{{- else if .Values.applications.metricsServer.repoUrl }}
repoUrl: {{ .Values.applications.metricsServer.repoUrl }}
{{- else }}
repoUrl: "https://kubernetes-sigs.github.io/metrics-server"
{{- end }}
{{- end }}


# {{/* Applications source */}}
## aws-load-balancer-controller
{{- define "awsLoadBalancerController.source" }}
{{- include "awsLoadBalancerController.repoUrl" .}}
chart: "aws-load-balancer-controller"
targetRevision: {{ .Values.applications.awsLoadBalancerController.chartVersion | default "HEAD" }}
{{- end }}

## aws-efs-csi-driver
{{- define "awsEfsCsiDriver.source" }}
{{- include "awsEfsCsiDriver.repoUrl" .}}
chart: "aws-efs-csi-driver"
targetRevision: {{ .Values.applications.awsEfsCsiDriver.chartVersion | default "HEAD" }}
{{- end }}

## cert-manager
{{- define "certManager.source" }}
{{- include "certManager.repoUrl" .}}
chart: "cert-manager"
targetRevision: {{ .Values.applications.certManager.chartVersion | default "HEAD" }}
{{- end }}

## cluster-autoscaler
{{- define "clusterAutoscaler.source" }}
{{- include "clusterAutoscaler.repoUrl" .}}
chart: "cluster-autoscaler"
targetRevision: {{ .Values.applications.clusterAutoscaler.chartVersion | default "HEAD" }}
{{- end }}

## external-dns
{{- define "externalDns.source" }}
{{- include "externalDns.repoUrl" .}}
chart: "external-dns"
targetRevision: {{ .Values.applications.externalDns.chartVersion | default "HEAD" }}
{{- end }}

## metrics-server
{{- define "metricsServer.source" }}
{{- include "metricsServer.repoUrl" .}}
chart: "metrics-server"
targetRevision: {{ .Values.applications.metricsServer.chartVersion | default "HEAD" }}
{{- end }}

# destination
{{- define "destination.server" }}
{{- if .Values.global.destination }}
server: {{ .Values.global.destination.server }}
{{- else }}
server: "https://kubernetes.default.svc"
{{- end }}
{{- end }}

# syncPolicy
{{- define "default.syncPolicy.automated" }}
automated: # automated sync by default retries failed attempts 5 times with following delays between attempts ( 5s, 10s, 20s, 40s, 80s ); retry controlled using `retry` field.
  prune: true # Specifies if resources should be pruned during auto-syncing ( false by default ).
  selfHeal: true # Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected ( false by default ).
{{- end }}
{{- define "default.syncPolicy.syncOptions" }}
syncOptions:     # Sync options which modifies sync behavior
  - Validate=false # disables resource validation (equivalent to 'kubectl apply --validate=true')
  - CreateNamespace=true # Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster.
{{- end }}
{{- define "default.syncPolicy.retry" }}
retry:
  limit: 5 # number of failed sync attempt retries; unlimited number of attempts if less than 0
  backoff:
    duration: 5s # the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
    factor: 2 # a factor to multiply the base duration after each failed retry
    maxDuration: 3m # the maximum amount of time allowed for the backoff strategy
{{- end }}
