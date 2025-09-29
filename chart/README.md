# aldehyde-lithium

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.31.0](https://img.shields.io/badge/AppVersion-1.31.0-informational?style=flat-square)

Helm Chart to deploy Logto as Auth System

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/dragonflydb/dragonfly/helm | maincache(dragonfly) | v1.34.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| adminIngress.className | string | `"traefik"` |  |
| adminIngress.enabled | bool | `false` |  |
| adminIngress.hosts[0].host | string | `nil` |  |
| adminIngress.hosts[0].paths[0].path | string | `"/"` |  |
| adminIngress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| adminIngress.tls | list | `[]` |  |
| affinity | object | `{}` |  |
| app.adminEndpoint | string | `""` |  |
| app.endpoint | string | `""` |  |
| app.trustProxyHeader | int | `1` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/logto-io/logto"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.className | string | `"traefik"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `nil` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/api/status"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| maincache.podSecurityContext.fsGroup | int | `1000` |  |
| maincache.podSecurityContext.runAsGroup | int | `1000` |  |
| maincache.podSecurityContext.runAsNonRoot | bool | `true` |  |
| maincache.podSecurityContext.runAsUser | int | `1000` |  |
| maincache.resources.limits.cpu | string | `"250m"` |  |
| maincache.resources.limits.memory | string | `"512Mi"` |  |
| maincache.resources.requests.cpu | string | `"100m"` |  |
| maincache.resources.requests.memory | string | `"256Mi"` |  |
| maincache.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| maincache.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| maincache.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| maincache.securityContext.runAsGroup | int | `3000` |  |
| maincache.securityContext.runAsNonRoot | bool | `true` |  |
| maincache.securityContext.runAsUser | int | `1000` |  |
| maincache.storage.enabled | bool | `false` |  |
| migrations.backoffLimit | int | `3` |  |
| migrations.enabled | bool | `true` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| oidc.rotate.backoffLimit | int | `0` |  |
| oidc.rotate.cookieKeys | bool | `false` |  |
| oidc.rotate.enabled | bool | `false` |  |
| oidc.rotate.schedule | string | `"0 0 * * *"` |  |
| oidc.rotate.type | string | `"ec"` |  |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | YAML Anchor for PodSecurityContext |
| preSetup | object | `{"backoffLimit":3,"enabled":true}` | - Pre-setup and migration Jobs (run before Deployment) |
| readinessProbe.httpGet.path | string | `"/api/status"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | int | `1` |  |
| resources.limits.memory | string | `"1Gi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| secrets.create | bool | `true` |  |
| secrets.data.DB_URL | string | `""` |  |
| secrets.nameOverride | string | `""` |  |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsGroup":3000,"runAsNonRoot":true,"runAsUser":1000}` | YAML Anchor for SecurityContext |
| service.containerPorts.admin | int | `3002` |  |
| service.containerPorts.http | int | `3001` |  |
| service.ports.admin | int | `3002` |  |
| service.ports.http | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceTree.layer | string | `"2"` |  |
| serviceTree.platform | string | `"aldehyde"` |  |
| serviceTree.service | string | `"lithium"` |  |
| syncWaves | object | `{"configmap":"3","deployment":"6","ingress":"6","migrationJob":"5","service":"6","setupJob":"4"}` | - Argo CD Sync Waves to orchestrate ordering |
| tags."atomi.cloud/layer" | string | `"2"` |  |
| tags."atomi.cloud/platform" | string | `"aldehyde"` |  |
| tags."atomi.cloud/service" | string | `"lithium"` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
