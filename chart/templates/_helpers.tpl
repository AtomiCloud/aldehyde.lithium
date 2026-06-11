{{/*
Expand the name of the chart.
*/}}
{{- define "aldehyde-lithium.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
allows triming of names
*/}}
{{- define "aldehyde-lithium.fullname-with-suffix" -}}
{{ $fname := (include "aldehyde-lithium.fullname" .root) }}
{{- printf "%s-%s" $fname .arg | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aldehyde-lithium.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Hostname of the Postgres that Logto connects to when the bundled DB is enabled.
Uses postgres.fullnameOverride (the bitnami subchart's service name); falls back
to the bitnami default "<release>-postgresql".
*/}}
{{- define "aldehyde-lithium.dbHost" -}}
{{- if .Values.postgres.fullnameOverride -}}
{{- .Values.postgres.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-postgresql" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/*
Logto DB connection string. Explicit secrets.data.DB_URL wins; otherwise, when the
bundled Postgres is enabled, derive it from postgres.auth + the bundled DB host.
*/}}
{{- define "aldehyde-lithium.dbUrl" -}}
{{- if .Values.secrets.data.DB_URL -}}
{{- .Values.secrets.data.DB_URL -}}
{{- else if .Values.postgres.enabled -}}
{{- printf "postgres://%s:%s@%s:5432/%s" .Values.postgres.auth.username .Values.postgres.auth.password (include "aldehyde-lithium.dbHost" .) .Values.postgres.auth.database -}}
{{- else -}}
{{- required "secrets.data.DB_URL must be set (e.g. postgres://user:pass@host:5432/logto), or enable postgres.enabled" .Values.secrets.data.DB_URL -}}
{{- end -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aldehyde-lithium.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "aldehyde-lithium.labels" -}}
{{- range $k, $v := .Values.serviceTree }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{ include "aldehyde-lithium.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "aldehyde-lithium.annotations" -}}
helm.sh/chart: {{ include "aldehyde-lithium.chart" . }}
{{- range $k, $v := .Values.serviceTree }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "aldehyde-lithium.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aldehyde-lithium.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $k, $v := .Values.atomiLabels }}
"atomi.cloud/{{ $k }}": "{{ $v }}"
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "aldehyde-lithium.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "aldehyde-lithium.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
