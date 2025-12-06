# n8n Docker Setup

A clean, minimal Docker setup for running n8n locally or on a NAS.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Copy the environment example file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and set your credentials:
   ```bash
   nano .env  # or use your preferred editor
   ```

3. Start n8n:
   ```bash
   docker-compose up -d
   ```

4. Access n8n at `http://localhost:5678`

## Configuration

All configuration is done through the `.env` file. Key settings:

- `N8N_PORT`: Port for the web interface (default: 5678)
- `N8N_BASIC_AUTH_USER`: Username for basic authentication
- `N8N_BASIC_AUTH_PASSWORD`: Password for basic authentication
- `GENERIC_TIMEZONE`: Timezone for n8n (default: Europe/Berlin)

## Data Storage

All n8n data (workflows, credentials, settings) is stored in `./n8n_data/`. This directory is:
- Automatically created when n8n starts
- Excluded from git (never commit secrets!)
- Easy to backup or move to another system

## Stopping n8n

```bash
docker-compose down
```

## Updating n8n

```bash
docker-compose pull
docker-compose up -d
```

## Moving to a NAS

To move this setup to a NAS:

1. Copy the entire project folder to your NAS
2. Ensure Docker/Docker Compose is installed on the NAS
3. Update the `.env` file with NAS-specific settings (hostname, etc.)
4. Run `docker-compose up -d`

The `./n8n_data/` directory contains all your workflows and settings, so everything will be preserved.