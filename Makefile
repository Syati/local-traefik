CERT_DIR := ./config/certs
CERT_HOSTS := "*.localhost" localhost 127.0.0.1 ::1

.PHONY: help
# ref: https://postd.cc/auto-documented-makefile/
help: ## Print help
	@awk -F '\n' -vRS='$(shell printf "#%.0s" {0..3}) ' \
		'{ \
			for(i=1; i<=NF; i++){ \
				if(NR==1) continue; \
				if(i==1) { \
					printf "[\033[33m%s\033[0m]\n", $$1; \
					continue \
				} \
				if($$i ~ /^[a-zA-Z].+:.*?##/){ \
					num = split($$i, res, ":.*?## "); \
					printf "\033[36mmake %-20s\033[0m %s\n", res[1], res[2] \
				} \
				if(i==NF) printf "\n" \
			} \
		}' \
		$(MAKEFILE_LIST)




.PHONY: setup
setup: ## Setup SSL certificates for local development using mkcert
	@echo "🔐 Setting up SSL certificates for local development..."
	
	# 1. Check if mkcert is installed
	@if ! command -v mkcert > /dev/null; then \
		echo "❌ mkcert not found. Please run 'brew install mkcert'."; \
		exit 1; \
	fi

	# 2. Install/trust the custom CA on Mac (skipped if already done)
	mkcert -install

	# 3. Create certificate output directory
	mkdir -p $(CERT_DIR)

	# 4. Generate project-specific certificates using local CA (private + public key pair)
	#    Note: Overwrites if already exists
	mkcert -cert-file $(CERT_DIR)/localhost.crt \
	       -key-file $(CERT_DIR)/localhost.key \
	       $(CERT_HOSTS)

	@echo "✨ Certificate creation completed! (under $(CERT_DIR)/)"

.PHONY: up
up: ## Start Traefik using Docker Compose
	@echo "🚀 Starting Traefik..."
	docker compose up -d

.PHONY: stop
stop: ## Stop Traefik
	@echo "🛑 Stopping Traefik..."
	docker compose stop

.PHONY: down
down: ## Stop and clean up Traefik
	@echo "🧹 Stopping and cleaning up Traefik..."
	docker compose down
