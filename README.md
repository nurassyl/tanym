## Requirements
                                                                                                                                                                              
- AMD64 CPU
- Docker v28+ 

---

Set Environments

```bash
cp .env.example .env
vim .env
```

Synchronize the time of the host machine with the docker machine so that firebase works correctly

```bash
sudo timedatectl set-timezone UTC
```

Docker: Build images

```bash
# in development mode
docker compose build

# in production mode
docker compose -f docker-compose.yml -f docker-compose.prod.yml build
```

Docker: Up containers

```bash
# in development mode
docker compose up -d

# in production mode
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

Log into postgres shell

```bash
psql $POSTGRES_USER $POSTGRES_DB
```

List databases

```
\l
```

