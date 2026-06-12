# NL2SQL Example

## Environment variables

Before building your dev container, copy `.devcontainer/.env.example` to `.devcontainer/.env` and edit it to your liking.

| Environment Variable | Description |
| --- | --- |
| COMPOSE_USER_ID | the UID of your OS account invoking `docker compose` command |
| COMPOSE_GROUP_ID | the GID of the account above |
| ANTHROPIC_API_KEY | your API key for Claude Code |
| ANALYST_PASSWORD | the password of the database user `analyst` used by Claude Code |
| POSTGRESQL_DATA_VOLUME | the name of the Docker named volume that holds the PostgreSQL data |

Note that the data volume for PostgreSQL must be created in advance.

## Copyright notice

The files in this repository are licensed under the Apache License Version 2.0.
