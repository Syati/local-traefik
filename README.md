# local-traefik

Local Traefik setup for development.

## What it provides

- Traefik v3 running with Docker Compose
- HTTP on `http://localhost`
- Dashboard on `http://localhost:8080`

## Requirements

- Docker
- Docker Compose

## Start and stop

```sh
make up
make stop
make down
```

## Notes

- The repository is intended for local development only.
- The TLS-enabled configuration is available on the `tls` branch.
