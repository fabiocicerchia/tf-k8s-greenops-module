output "namespace" {
  description = "Kubernetes namespace where KubeGreen is deployed"
  value       = helm_release.kubegreen.namespace
}

output "release_name" {
  description = "Helm release name of KubeGreen"
  value       = helm_release.kubegreen.name
}

output "chart_version" {
  description = "Chart version of KubeGreen deployment"
  value       = helm_release.kubegreen.version
}
