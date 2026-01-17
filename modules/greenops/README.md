# GreenOps Module

Comprehensive Terraform module for deploying a complete green operations monitoring stack on Kubernetes. Includes Prometheus, KEDA, OpenCost, and Kepler Operator with individual toggles for selective component deployment.

## Features

- **Selective Deployment**: Enable or disable components individually via feature toggles
- **Prometheus Monitoring**: Complete monitoring and metrics stack with Grafana
- **KEDA Autoscaling**: Event-driven workload scaling with optional examples
- **OpenCost**: Cloud cost monitoring and allocation with carbon tracking
- **Kepler Operator**: Environmental impact and power consumption tracking
- **Flexible Configuration**: Customize each component independently with HCL values

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |
| null | >= 3.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster (v1.24+)

## Usage

### Deploy All Components (Default)

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  deploy_demo_app = true
}
```

### Deploy Specific Components

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  prometheus = {
    enabled = true
  }

  keda = {
    enabled = false
  }

  opencost = {
    enabled = true
  }

  kepler = {
    enabled = true
  }
}
```

### Custom Configuration

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"

  prometheus = {
    enabled      = true
    namespace    = "custom-monitoring"
    release_name = "prom"
    values = {
      prometheus = {
        prometheusSpec = {
          retention = "30d"
        }
      }
    }
  }

  keda = {
    enabled        = true
    namespace      = "custom-keda"
    deploy_example = false
    values         = {}
  }

  opencost = {
    enabled = true
    values = {
      opencost = {
        carbonCost = {
          enabled = true
        }
      }
    }
  }

  kepler = {
    enabled             = true
    namespace           = "sustainability"
    deploy_powermonitor = true
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| prometheus | Prometheus module configuration | `object({...})` | `{ enabled = true, ... }` | no |
| keda | KEDA module configuration | `object({...})` | `{ enabled = true, ... }` | no |
| opencost | OpenCost module configuration | `object({...})` | `{ enabled = true, ... }` | no |
| kepler | Kepler module configuration | `object({...})` | `{ enabled = true, ... }` | no |

### Detailed Input Schema

#### prometheus
```hcl
prometheus = {
  enabled      = bool                    # Enable Prometheus (default: true)
  release_name = string                  # Helm release name (default: "prometheus-community")
  namespace    = string                  # Kubernetes namespace (default: "monitoring")
  values       = any                     # Helm chart values (default: {...})
}
```

#### keda
```hcl
keda = {
  enabled        = bool                  # Enable KEDA (default: true)
  release_name   = string                # Helm release name (default: "kedacore")
  namespace      = string                # Kubernetes namespace (default: "keda")
  values         = any                   # Helm chart values (default: {})
  deploy_example = bool                  # Deploy example manifests (default: true)
  manifest_path  = string                # Path to example manifest (default: "keda.yaml")
}
```

#### opencost
```hcl
opencost = {
  enabled      = bool                    # Enable OpenCost (default: true)
  release_name = string                  # Helm release name (default: "opencost-charts")
  namespace    = string                  # Kubernetes namespace (default: "opencost")
  values       = any                     # Helm chart values (default: {...})
}
```

#### kepler
```hcl
kepler = {
  enabled             = bool             # Enable Kepler (default: true)
  release_name        = string           # Helm release name (default: "kepler-operator")
  namespace           = string           # Kubernetes namespace (default: "kepler-operator")
  values              = any              # Helm chart values (default: {...})
  deploy_powermonitor = bool             # Deploy PowerMonitor (default: true)
}
```

## Outputs

| Name | Description |
|------|-------------|
| prometheus_namespace | Prometheus Kubernetes namespace (if enabled) |
| prometheus_release_name | Prometheus Helm release name (if enabled) |
| prometheus_chart_version | Prometheus chart version (if enabled) |
| keda_namespace | KEDA Kubernetes namespace (if enabled) |
| keda_release_name | KEDA Helm release name (if enabled) |
| keda_chart_version | KEDA chart version (if enabled) |
| opencost_namespace | OpenCost Kubernetes namespace (if enabled) |
| opencost_release_name | OpenCost Helm release name (if enabled) |
| opencost_chart_version | OpenCost chart version (if enabled) |
| kepler_namespace | Kepler Kubernetes namespace (if enabled) |
| kepler_release_name | Kepler Helm release name (if enabled) |
| kepler_chart_version | Kepler chart version (if enabled) |

## Architecture

```
greenops (orchestration module)
├── prometheus (metrics collection)
├── keda (event-driven autoscaling)
├── opencost (cost & carbon tracking)
├── kepler (environmental impact tracking)
└── demo_app (optional sample workload)
```

### Module Dependencies

- **Cert Manager**: Automatically deployed as a dependency of Kepler Operator
- **Prometheus ServiceMonitors**: Configured for all components when enabled
- **Demo App**: Depends on greenops module completion

## Configuration Examples

### Minimal Deployment

Only enable Prometheus for basic monitoring:

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  prometheus = { enabled = true }
  keda       = { enabled = false }
  opencost   = { enabled = false }
  kepler     = { enabled = false }
}
```

### Cost Tracking Focus

Enable Prometheus and OpenCost for cost visibility:

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  prometheus = { enabled = true }
  opencost   = { enabled = true }
}
```

### Sustainability Monitoring

Complete stack for environmental tracking:

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=main"

  # All enabled by default, just provide custom values if needed
  prometheus = {
    enabled = true
  }

  opencost = {
    enabled = true
  }

  kepler = {
    enabled = true
  }
}
```

## Using Different Git References

Deploy from specific tags, branches, or commits:

```hcl
module "greenops" {
  source = "https://github.com/fabiocicerchia/kepler-module.git?ref=v1.0.0"
  # or use: ref=develop, ref=main, ref=abc1234 (commit SHA)
}
```

## Troubleshooting

### Check Deployment Status

```bash
# Check all pods
kubectl get pods -A

# Check specific component
kubectl get pods -n monitoring
kubectl get pods -n keda
kubectl get pods -n opencost
kubectl get pods -n kepler-operator
```

### View Component Logs

```bash
# Prometheus
kubectl logs -n monitoring -l app.kubernetes.io/name=prometheus

# KEDA
kubectl logs -n keda -l app=keda-operator

# OpenCost
kubectl logs -n opencost -l app=opencost

# Kepler
kubectl logs -n kepler-operator -l app.kubernetes.io/name=kepler
```

### Access Services Locally

```bash
# Prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090

# Grafana
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80

# OpenCost
kubectl port-forward -n opencost svc/opencost 9090
```

## Related Resources

- [Prometheus Community Helm Charts](https://github.com/prometheus-community/helm-charts)
- [KEDA Documentation](https://keda.sh/)
- [OpenCost Project](https://www.opencost.io/)
- [Kepler Project](https://sustainable-computing.io/)
