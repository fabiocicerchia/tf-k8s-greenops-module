variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for Scaphandre"
  type        = string
  default     = "scaphandre"
}

variable "namespace" {
  description = "Kubernetes namespace for Scaphandre"
  type        = string
  default     = "scaphandre"
}

variable "values" {
  description = "Scaphandre Helm chart values"
  type        = any
  default     = {}
}
