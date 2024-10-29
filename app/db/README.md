# Data Base ***Postgres***

Nesse documento é descrito o processo de instalação e configuração do banco de dados.

## Instalação Docker Ubuntu

Numa vm com sistema operacional Ubuntu execute o comando abaixo:

```sh
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Instalação Docker Compose

Ainda na vm execute o comando abaixo para instalação do docker compose:

```sh
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
```

## Instalação Postgres

Para rodarmos o banco de dados postgres na vm iremos executar um arquivo compose.yaml

Crie arquivo compose.yaml

```sh
sudo vim compose.yaml
```

Descreva as instruções do manifesto conforme exemplo abaixo:

```yaml
version: '3.5'

services:
  db:
    container_name: ${DB_HOSTNAME}
    image: ${DB_IMAGE}
    networks:
      - bza_network
    restart: always
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - POSTGRES_DB=${POSTGRES_DB}
    ports:
      - ${DB_PORT_EXT}:${DB_PORT_INT}  
    volumes:
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
      - db_vol:/var/lib/postgresql/data

networks:
  bza_network: {}
volumes:
  db_vol: {}
```

Crie um arquivo .env

```sh
sudo vim .env
```

Descreva no arquivos as informações das variáveis de ambiente conforme exemplo abaixo:

```text
POSTGRES_USER=develop
POSTGRES_PASSWORD=develop
POSTGRES_HOST=localhost
POSTGRES_DB=bza
DB_PORT_EXT=5454
DB_PORT_INT=5432
DB_HOSTNAME=db_pg12
DB_IMAGE=postgres:12-alpine
```

Agora execute o manifesto compose junto com o .env

```sh
docker-compose --env-file .env -f compose.yaml up -d --build --force-recreate
```
