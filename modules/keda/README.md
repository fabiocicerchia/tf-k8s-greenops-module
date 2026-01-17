# KEDA Module

Terraform module to deploy KEDA (Kubernetes Event Driven Autoscaling) on your Kubernetes cluster using Helm. This module is part of the [tf-k8s-greenops-module](https://github.com/fabiocicerchia/tf-k8s-greenops-module) for comprehensive Kubernetes monitoring and optimization.

## Overview

KEDA enables intelligent autoscaling based on events and custom metrics, not just CPU/memory. It complements the monitoring stack by allowing automatic scaling responses to system conditions.

- **Event-Driven Autoscaling**: Scale Kubernetes workloads based on external events
- **Multiple Scalers**: Support for various event sources (HTTP, Kafka, AWS, GCP, Azure, etc.)
- **Example Deployments**: Optional deployment of KEDA example manifests for testing

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |
| null | >= 3.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster

## Usage

### Basic Usage

```hcl
module "keda" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/keda?ref=v1.0.0"

  kubeconfig_path = "~/.kube/config"
  release_name    = "kedacore"
  namespace       = "keda"
  values          = {}
}
```

### Without Example Manifests

```hcl
module "keda" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/keda?ref=main"

  deploy_example = false
}
```

### With Custom Namespace

```hcl
module "keda" {
  source = "https://github.com/fabiocicerchia/tf-k8s-greenops-module.git//modules/keda?ref=main"

  namespace      = "custom-keda"
  manifest_path  = "${path.module}/custom-keda-manifest.yaml"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| release_name | Helm release name for KEDA | `string` | `"kedacore"` | no |
| namespace | Kubernetes namespace for KEDA | `string` | `"keda"` | no |
| values | KEDA Helm chart values | `any` | `{}` | no |
| deploy_example | Deploy KEDA example manifests | `bool` | `true` | no |
| manifest_path | Path to KEDA manifest file | `string` | `"keda.yaml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart_version | Chart version of KEDA deployment |
| namespace | Kubernetes namespace where KEDA is deployed |
| release_name | Helm release name of KEDA |

## Notes

- KEDA example manifest file should be present in your working directory unless overridden
- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- kubectl must be available in your PATH if deploying example manifests
- Values are passed directly to the Helm chart as HCL objects

## Related Resources

- [KEDA Documentation](https://keda.sh/)
- [KEDA GitHub Repository](https://github.com/kedacore/keda)
- [KEDA Helm Charts](https://github.com/kedacore/charts)
