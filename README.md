# local-traefik

Local Traefik setup for development.

## What it provides

- Traefik v3 running with Docker Compose
- HTTP on `http://localhost`
- HTTPS on `https://localhost`
- Dashboard on `http://localhost:8080`
- Local certificates generated with `mkcert`

## Requirements

- Docker
- Docker Compose
- `mkcert`

## Setup

```sh
make setup
```

This installs the local CA if needed and generates certificates under `config/certs/`.

## Start and stop

```sh
make up
make stop
make down
```

## Notes

- The repository is intended for local development only.
- `config/certs/` is ignored in git because the certificates are generated locally.
