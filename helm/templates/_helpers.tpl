{{- define "memory-monster.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}   # => myrelease-todolist
{{- end -}}
