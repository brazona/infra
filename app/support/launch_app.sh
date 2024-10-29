#!/bin/bash

DIRETORIO_ROOT=./
DIRETORIO_APP=./app/
FILE_NAME=.env
DIRETORIO_ENV=$DIRETORIO_ROOT$FILE_NAME
FILE_COMPOSE=local/compose.yaml
FILE_COMPOSE_RUN=local/compose-run.yaml
SCRIPT_NETWORK=create_network.sh
DIRETORIO_SCRIPT=$DIRETORIO_ROOT$SCRIPT_NETWORK

## Verifica se arquivo .env esta disponível root
if [ -e "$DIRETORIO_ENV" ] ; then
  echo "Arquivo .env localizado no diretório: "$DIRETORIO_ENV
else
  echo "Arquivo .env não foi localizado no diretório: "$DIRETORIO_ENV
  DIRETORIO_ENV=$DIRETORIO_APP$FILE_NAME
fi

## Verifica se arquivo .env esta disponível no diretório app
if [ -e "$DIRETORIO_ENV" ] ; then
  echo "Arquivo $FILE_NAME localizado no diretório: "$DIRETORIO_ENV
else
  echo "Arquivo $FILE_NAME não foi localizado no diretório: "$DIRETORIO_ENV
  exit 2
fi

# Verifica se arquivo tem conteúdo
CONTENT_FILE=$(cat $DIRETORIO_ENV)
if [ -z "$CONTENT_FILE" ]; then
  echo "Arquivo .env sem conteúdo, insira os valores das variaveis no arquivo: "$DIRETORIO_ENV
  exit 2
else
  echo "Arquivo .env possui conteúdo"
fi

## Verifica se arquivo script que cria network esta disponível root
if [ -e "$DIRETORIO_SCRIPT" ] ; then
  echo "Arquivo $SCRIPT_NETWORK localizado no diretório: "$DIRETORIO_SCRIPT
else
  echo "Arquivo $SCRIPT_NETWORK não foi localizado no diretório: "$DIRETORIO_SCRIPT
  DIRETORIO_SCRIPT=$DIRETORIO_APP$SCRIPT_NETWORK
fi

## Verifica se arquivo .env esta disponível no diretório app
if [ -e "$DIRETORIO_SCRIPT" ] ; then
  echo "Arquivo $SCRIPT_NETWORK localizado no diretório: "$DIRETORIO_SCRIPT
else
  echo "Arquivo $SCRIPT_NETWORK não foi localizado no diretório: "$DIRETORIO_SCRIPT
  exit 2
fi
## executa script rede docker
sh $DIRETORIO_SCRIPT

## Verifica os paramentros
if [ "$#" -lt 1 ]; then
  echo "É obrigatório o uso de ao menos 1 paramentro para executar esse script"
  echo "Exemplo: app/launch_app.sh grafana-prometheus keycloak postgres"
  exit 1
fi
echo "---> Listando argumentos :"
num=1
for arg in "$@"; do
  echo "argumento #$num = $arg"
  ((num++))
done

num=1
for arg in "$@"; do
  echo "executando compose: $arg"
  rm -rf $DIRETORIO_COMPOSE_RUN
  DIRETORIO_COMPOSE=$DIRETORIO_ROOT$arg/$FILE_COMPOSE
  DIRETORIO_COMPOSE_RUN=$DIRETORIO_ROOT$arg/$FILE_COMPOSE_RUN

  ## Verifica se arquivo compose esta disponível root
  if [ -e "$DIRETORIO_COMPOSE" ] ; then
    echo "Arquivo $FILE_COMPOSE localizado no diretório: "$DIRETORIO_COMPOSE
  else
    echo "Arquivo $FILE_COMPOSE não foi localizado no diretório: "$DIRETORIO_COMPOSE
    DIRETORIO_COMPOSE=$DIRETORIO_APP$arg/$FILE_COMPOSE
    DIRETORIO_COMPOSE_RUN=$DIRETORIO_APP$arg/$FILE_COMPOSE_RUN
  fi

  ## Verifica se arquivo compose.yaml esta disponível no diretório app
  if [ -e "$DIRETORIO_COMPOSE" ] ; then
    echo "Arquivo $FILE_COMPOSE localizado no diretório: "$DIRETORIO_COMPOSE
  else
    echo "Arquivo $FILE_COMPOSE não foi localizado no diretório: "$DIRETORIO_COMPOSE
    exit 2
  fi
  
  echo "executado compose: $arg"
  cp  $DIRETORIO_COMPOSE $DIRETORIO_COMPOSE_RUN
  ## Ler arquivo .env e atualiza variaveis de ambiente
  while read -r line || [[ -n "$line" ]];
  do
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    replace=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')
    find='${'$varname'}'
    sed -i 's,'"$find"','$replace',' "$DIRETORIO_COMPOSE_RUN"
  done < $DIRETORIO_ENV

  #docker-compose --env-file $DIRETORIO_ENV config
  #docker-compose --env-file $DIRETORIO_ENV -f $DIRETORIO_COMPOSE up
  #docker-compose --env-file $DIRETORIO_ENV -f $DIRETORIO_COMPOSE up -d --build --force-recreate
  docker-compose --env-file $DIRETORIO_ENV -f $DIRETORIO_COMPOSE_RUN up -d --build --force-recreate
  rm -rf $DIRETORIO_COMPOSE_RUN
  ((num++))
done

# echo "Nome do script: $0"
# echo "Número total de parâmetros: $#"
# echo "Primeiro parâmetro: $1"
# echo "Segundo parâmetro: $2"
# echo "Décimo quinto parâmetro: ${15}"
# echo "Todos os parâmetros: $*"
# echo "Número total de parâmetros: $#"

# $ ./parametros.sh a b c d e f g h i j k l m n o p q r s t u v w x y z
# Nome do script: ./parametros.sh
# Número total de parâmetros: 26
# Primeiro parâmetro: a
# Segundo parâmetro: b
# Décimo quinto parâmetro: o
# Todos os parâmetros: a b c d e f g h i j k l m n o p q r s t u v w x y z


## Ler a versão do arquivo pom.xml e atualiza variavél de ambiente
# VALUE_VERSION=$(xmllint --xpath '/*[local-name()="project"]/*[local-name()="version"]/text()' "$DIR_POM")

# ## Ler arquivo .env e atualiza variaveis de ambiente
# while read -r line || [[ -n "$line" ]];
# do
#   varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
#   varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')

#   if [ $varname = $KEY_VERSION ]; then
#     find=$varname=$varvalue
#     replace=$varname=$VALUE_VERSION
#     sed -i 's,'$find','$replace',' "$DIRETORIO_ENV"
#   fi
# done < $DIRETORIO_ENV

# mvn clean install -P build -DskipTests
# docker compose --env-file $DIRETORIO_ENV up -d --build --force-recreate
