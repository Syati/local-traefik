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
.PHONY: up
up: ## Start Traefik using Docker Compose
	@echo "🚀 Starting Traefik..."
	docker compose up -d

.PHONY: stop
stop: ## Stop Traefik
	@echo "🛑 Stopping Traefik..."

