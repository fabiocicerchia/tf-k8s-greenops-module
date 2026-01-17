variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

# Prometheus configuration
variable "prometheus" {
  description = "Prometheus module configuration"
  type = object({
    enabled      = bool
    release_name = optional(string, "prometheus-community")
    namespace    = optional(string, "monitoring")
    values       = optional(any, {})
  })
  default = {
    enabled = true
  }
}

# KEDA configuration
variable "keda" {
  description = "KEDA module configuration"
  type = object({
    enabled        = bool
    release_name   = optional(string, "kedacore")
    namespace      = optional(string, "keda")
    values         = optional(any, {})
    deploy_example = optional(bool, true)
    manifest_path  = optional(string, "keda.yaml")
  })
  default = {
    enabled = true
  }
}

# OpenCost configuration
variable "opencost" {
  description = "OpenCost module configuration"
  type = object({
    enabled      = bool
    release_name = optional(string, "opencost-charts")
    namespace    = optional(string, "opencost")
    values       = optional(any, {})
  })
  default = {
    enabled = true
  }
}

# Kepler configuration
variable "kepler" {
  description = "Kepler module configuration"
  type = object({
    enabled             = bool
    release_name        = optional(string, "kepler-operator")
    namespace           = optional(string, "kepler-operator")
    values              = optional(any, {})
    deploy_powermonitor = optional(bool, true)
  })
  default = {
    enabled = true
  }
}

# Scaphandre configuration
variable "scaphandre" {
  description = "Scaphandre module configuration"
  type = object({
    enabled      = bool
    release_name = optional(string, "scaphandre")
    namespace    = optional(string, "scaphandre")
    values       = optional(any, {})
  })
  default = {
    enabled = false
  }
}

# KubeGreen configuration
variable "kubegreen" {
  description = "KubeGreen module configuration"
  type = object({
    enabled      = bool
    release_name = optional(string, "kube-green")
    namespace    = optional(string, "kube-green")
    values       = optional(any, {})
  })
  default = {
    enabled = false
  }
}
