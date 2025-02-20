# Deploy com docker compose

Para atender a necessidade de executar a os servidore em ambiente local, foi criado um manifesto compose que inicia as configurações iniciais dos servidores, proporcionando os recursos da arquitetura em ambiente **localhost.**

Para executar essa instrução basta abrir o terminal shell, e executar com exemplo abaixo:

```sh
bash compose.sh support/wiki
```

Informando ao argumento do arquivo shell, os nomes dos servidores que deseja executar.

```sh
bash compose.sh db
```

> [!NOTE]
> Para executar o comando acima citado, é necessário incluir no diretório **app/**, o arquivo .env, que fornecerá ao docker compose as variáveis de ambiente.
> Procure o arquiteto do projeto e solicite o arquivo **.env**.

## Licença

> [!IMPORTANT]
> *O código fonte neste projeto não possui licença de uso.*

É terminantemente proibido reproduzir, distribuir, alterar, utilizar engenharia reversa ou valer-se de qualquer tentativa de reverter ao seu código-fonte qualquer dos componentes que compõem o SOFTWARE, bem como utilizar subterfúgios para burlar a quantidade de usuários licenciados.
