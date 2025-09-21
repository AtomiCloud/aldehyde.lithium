# Logto App Secret (Single Secret)

Provide one Secret for all sensitive settings, or let the chart create it via `values.yaml`.

Secret name

- Default: `<release>-aldehyde-lithium-app`
- Override: `secrets.nameOverride`

Required keys

- `DB_URL`: Postgres connection string. Example: `postgres://user:pass@host:5432/logto`

Optional keys

- `REDIS_URL`: Redis/Dragonfly URL. Defaults to `redis://<release>-dragonfly:6379` if omitted.
- `S3_ACCESS_KEY_ID`: S3 access key (when `STORAGE_TYPE=s3`).
- `S3_SECRET_ACCESS_KEY`: S3 secret key (when `STORAGE_TYPE=s3`).
- `JWT_SECRET`: Symmetric token key (only if not fully relying on DB‑managed keys and rotation).

Create via values.yaml (chart creates Secret)

- Set under `secrets.data.*`. Example:

```
secrets:
  create: true
  data:
    DB_URL: postgres://user:pass@db:5432/logto
    REDIS_URL: redis://dragonfly:6379
    S3_ACCESS_KEY_ID: AKIA...
    S3_SECRET_ACCESS_KEY: ...
    JWT_SECRET: change-me
```

Create manually

```
kubectl create secret generic <name> \
  --from-literal=DB_URL='postgres://user:pass@db:5432/logto' \
  --from-literal=REDIS_URL='redis://dragonfly:6379' \
  --from-literal=S3_ACCESS_KEY_ID='...' \
  --from-literal=S3_SECRET_ACCESS_KEY='...' \
  --from-literal=JWT_SECRET='change-me'
```

Then set:

```
secrets:
  create: false
  nameOverride: <name>
```
