{{- define "ui.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
{{- define "ui.container" -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag }}
{{- end -}}
