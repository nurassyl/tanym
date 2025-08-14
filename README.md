# Project Setup Guide

## Requirements

- **AMD64 CPU with AVX Support**
- **Docker v28+**

---

## System Configuration for High-Performance Networking and Docker Limits

### 1. Update `sysctl` Configuration
Open the system configuration file:
```bash
sudo vim /etc/sysctl.conf
```

Add or update the following parameters:
```ini
net.core.somaxconn = 65535
fs.file-max = 2097152
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_tw_reuse = 1
```

Apply the changes:
```bash
sudo sysctl --system
```

Verify the settings inside the Docker container:
```bash
docker exec -it tanym-postgres cat /proc/sys/net/core/somaxconn
```

### 2. Increase `ulimit` for Docker Containers
Edit Docker's daemon configuration:
```bash
sudo vim /etc/docker/daemon.json
```

Add the following configuration:
```json
{
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 200000,
      "Soft": 200000
    },
    "nproc": {
      "Name": "nproc",
      "Hard": 200000,
      "Soft": 200000
    }
  }
}
```

Restart Docker:
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart docker
```

---

# Docker Setup & Usage Guide

A step-by-step guide to setting up your environment, building Docker images, and managing containers, with explanations for each step.

### 1. **Set Up Environment Variables**
First, copy the example environment file and edit it with your preferred values.
```bash
cp .env.example .env
vim .env
```
**Why:** The `.env` file stores configuration such as database credentials and API keys.

### 2. **Synchronize System Time**
Make sure your host machine's timezone is set to UTC for services like Firebase to work correctly.
```bash
sudo timedatectl set-timezone UTC
```
**Why:** Time mismatches can cause authentication, token expiry, and logging issues.

### 3. **Build Docker Images**
Depending on your environment:

**Development mode:**
```bash
docker compose build
```
**Production mode:**
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml build
```
**Why:** Building images ensures all dependencies and services are packaged and ready.

### 4. **Start Docker Containers**

**Development mode:**
```bash
docker compose up -d
```
**Production mode:**
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```
**Why:** `-d` runs containers in detached mode so they stay running in the background.

---

## PostgreSQL

### Access PostgreSQL Shell
```bash
psql $POSTGRES_USER $POSTGRES_DB
```
**Why:** Allows direct interaction with your PostgreSQL database.

### List All Databases
Inside the PostgreSQL shell:
```psql
\l
```
**Why:** To verify existing databases and check connectivity.

---

## Lint
```bash
docker exec dev-tanym bundle exec rubocop
```

---

## Tasks

- ~~Init Rails app~~
- ~~Init PostgreSQL~~
- ~~Init Redis for caching and distributed locking~~
- Init Telegram Bot
- Set up Nginx or Apache2 with Puma server and worker processes
- Init web: cookie, session storage, cookie name, CORS, CSRF/XSRF, middleware, user-agent, locale, get IP address
- Init auth, token auth for mobile app, and cookie/session auth for web
- Init frontend: nodejs, webpack, inertia, svelte, typescript, eslint, prettier, sass, postcss, autoprefixer, bootstrap, i18n, axios, router, 404 page, 5xx page, favicon
- Init Admin-Panel
- Init Active Job
- Init Active Storage
- Init Active Cable
- Init Anti-DDoS: lock by user, cookie, auth header, route paths
- Init IP Rate Limit
- Init slow query log
- Init logrotate
- Init backup
- Enabling Controller Caching for Performance in config/environments/production.rb: config.action_controller.perform_caching = false in production mode
- Init redis-rack-cache
- Enable bootsnap in production mode
- Init Rails Thruster
- Init MongoDB
- Setup dedicated Redis server with memory optimizations (disable THP, enable overcommit_memory)

