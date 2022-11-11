{{- define "mongo.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}
{{- define "mongo.container" -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag }}
{{- end -}}
