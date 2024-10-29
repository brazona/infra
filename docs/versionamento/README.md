# Versionamento

O versionamento do código garante controle das versões do aplicativo mantendo a entrega das funcionalidades, o rastreamento das implementações organizados, assim acarretando numa melhor qualidade do software e satisfação do cliente.

## Estratégia de Versionamento

Definir uma boa estratégia propecia a padronização de processos com qualidade, garantindo a entrega com qualidade.

### Branch

A branch é a ramificação do código fonte e porta de entrada das diversas interações e implementações de algoritimo no código versionado.

Para garantir o processo padronizado a tabela de ***Tabela Branch*** foi definida, alinhada com o conceito de [GITFLOW](https://fullcycle.com.br/o-que-e-git-flow/), conforme abaixo descrito.

| Branch | Descrição | Tipo |
| --- | --- | --- |
| main | A branch que contém a versão principal, utilizada pelo usuário final. | Permanente |
| develop | Esta é utilizada para o desenvolvimento, unificando versões para o processo. | Permanente |
| hotfix/** | Utilizada para corrigir bugs, aplicadas diretamente na branch main. | Auxiliar |
| release/** | Nessa branch centraliza todas as funcionalidades implementadas de uma versão de lançamento. | Auxiliar |
| feature/** | Branch utilizada para o desenvolvimento individual de uma funcionalidade. | Auxiliar |

### Estratégia de Ambientes

Os ambientes são espaços dedicados para a implementação do aplicativo conforme a necessidade, significa que cada ambiente funciona de forma idenpendente, sem relação e interferencia. 

Para tal foi descrito a tabela abaixo, afim de orientar e padronizar os objetivos.

| Abreviação | Ambiente | Descrição |
| --- | --- | --- |
| dsv | Desenvolvimento | Ambiente destinado para o processo de desenvolvimento |
| hmg | Homologação | Destinado ao processo de homologação |
| stg | Staging | Reflexo do ambiente de Produção, disponibilizado para avaliações e testes sem interfência direta em Produção |
| prd |Produção | Ambiente principal, pois nele esta a versão do software que o usuário final utiliza |

### Relação Branch e Ambientes

Para identificação das versões disponivel em cada ambiente, é necessário criar uma relação, entre branch e ambiente.

Abaixo segue a tabela Branch x Ambiente, que descreve tal relação.

| Branch | Ambiente | Evento |
| --- | --- | --- |
| develop | Aplica no ambiente __DSV__ | Pull Request |
| release/** | Aplica no ambiente __HMG__ | Pull Request |
| main | Aplica no ambiente __STG__ | Pull Request |
| main | Aplica no ambiente __PRD__ | Merge |

> [!CAUTION]
> *É expressamente vetado a publicação diretamente nas branchs principais, sempre utilizar o processo de Pull request.*
