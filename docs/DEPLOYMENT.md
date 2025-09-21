# Logto OSS Helm Deployment (with maincache)

This guide deploys Logto OSS with Dragonfly (Redis) named `<release>-maincache`, sets
up required secrets, and exposes both app and admin ports with Ingress. Commands assume
Helm + kubectl are installed; for repo tooling use `direnv allow && nix develop`.

## 1) Prepare values override

Create `values.override.yaml` with environment‑specific config. Use a real domain and S3 only if needed.

```
app:
  endpoint: https://auth.example.com
  adminEndpoint: https://admin-auth.example.com

s3:
  config:
    storageType: s3
    bucket: your-bucket
    endpoint: s3.amazonaws.com
    region: us-east-1

# Name the cache service as <release>-maincache (already default in chart dependency)
maincache:
  fullnameOverride: "myrelease-maincache"

ingress:
  enabled: true
  className: traefik
  hosts:
    - host: auth.example.com
      paths:
        - path: /
          pathType: ImplementationSpecific

adminIngress:
  enabled: true
  className: traefik
  hosts:
    - host: admin-auth.example.com
      paths:
        - path: /
          pathType: ImplementationSpecific
```

Notes:

- If you don’t use S3, keep `s3.config` but omit S3 secrets.
- Service ports (values.yaml): app `http` (3001), admin (3002).

## 2) Create the single Secret (required)

Recommended: create it yourself (so CI/CD doesn’t see creds). The chart defaults `REDIS_URL` to `redis://<release>-maincache:6379` when omitted.

```
export RELEASE=myrelease
kubectl create secret generic ${RELEASE}-aldehyde-lithium-app \
  --from-literal=DB_URL='postgres://user:pass@db:5432/logto' \
  --from-literal=REDIS_URL='redis://'"${RELEASE}"'-maincache:6379' \
  --from-literal=S3_ACCESS_KEY_ID='...' \
  --from-literal=S3_SECRET_ACCESS_KEY='...' \
  --from-literal=JWT_SECRET='change-me' \
  -n default
```

If you prefer the chart to create the Secret, set under `secrets.data.*` in values and keep `secrets.create: true`.

## 3) Install/upgrade

```
helm dependency update chart
helm upgrade --install myrelease chart/ -f values.override.yaml
```

The app exposes:

- Service `http` → container 3001; Ingress set by `ingress.*`
- Service `admin` → container 3002; Ingress set by `adminIngress.*`

## 4) Argo CD sync order

- Wave 3: ConfigMap + Secret + ServiceAccount
- Wave 4: DB seed Job (idempotent; skips if seeded)
- Wave 5: DB alteration Job (idempotent), OIDC rotation CronJob (mutable by design)
- Wave 6: Deployment, HPA
- Wave 7: Service
- Wave 8: Ingress (app + admin)

## 5) Connector pins (optional but recommended)

To list all official Logto connectors with their latest versions (for pinning), run:

```
pls connectors:list
```

This prints one `@logto/connector-…@<version>` per line.
