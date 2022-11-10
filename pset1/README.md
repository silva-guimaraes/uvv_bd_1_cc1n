# PSET 1
Banco de dados de um modelo de empresa feito para recursos humanos e gestão de pessoas.

Informações contidas:
- empregados
- departamentos
- histórico de cargos
- cargos
- localizações
- paises e regiões

## Instale
### SGBD
Apenas disponivel para [PostgresSQL](https://www.postgresql.org/download/) e [MariaDB/MySQL](https://mariadb.org/download/). Das duas opções, escolha um sistema de gerenciamente de sua prefêrencia, siga as instruções de como instalar o servidor clicando em um dos links, e após todas as configurações siga para o proximo passo.

### Scripts
Assumindo que esteja usando a versão linha de comando do git:
```
git clone https://github.com/silva-guimaraes/uvv_bd_1_cc1n/
```
Logo em seguida navegue até esta mesma pasta e execute o script para o seu SGBD. Assumindo que você tenha feita uma instalação padrão:

PostgreSQL:
```
psql -U postgres < cc1n_202203061_postgresql.sql
```
MariaDB/Mysql:
```
mysql -u root -p < cc1n_202203061_mysql.sql
```
Uma mensagem ao final da execução dizendo 'sucesso!' sinaliza que a instalação foi concluida sucessivamente.

## Tabelas
Todas as tabelas no PostgreSQL são criadas dentro do esquema "hr".

| Tabela              | Nome Físico      | Descrição                                                                                                         |
|---------------------|------------------|-------------------------------------------------------------------------------------------------------------------|
| Regiões             | regioes          | Representa principais regiões e continentes. Regiões possuem países.                                              |
| Países              | paises           | Representa países. Países ficam em regiões e países possuem localizações.                                         |
| Localizações        | localizacoes     | Representa localizações. localizações ficam em paises e localizações possuem departamentos.                       |
| Departamentos       | departamentos    | Representa locais físicos de trabalho de todos os tipos. Departamentos possuem gerentes encarregados do local.    |
| Empregados          | empregados       | Representa empregados. Supervisores e gerentes inclusos.                                                          |
| Cargos              | cargos           | Listagem de todos os cargos existentes.                                                                           |
| Histórico de Cargos | historico_cargos | Armazena todos os cargos passados de cada empregado. Essa tabela não armazena os cargos atuais de cada empregado. |

## Colunas
### Empregados
| Nome físico      | Tipo                 | chave                  | null? |
|------------------|----------------------|------------------------|-------|
| id_empregado     | INTEGER              | Primary                | N     |
| nome             | VARCHAR(75)          | N                      | N     |
| email            | VARCHAR(35)          | Unique                 | N     |
| telefone         | VARCHAR(20)          | N                      | S     |
| data_contratacao | DATE                 | N                      | N     |
| id_cargo         | VARCHAR(10)          | Foreign(cargos)        | N     |
| salario          | NUMERIC/DECIMAL(8,2) | N                      | S     |
| comissao         | NUMERIC/DECIMAL(8,2) | N                      | S     |
| id_departamento  | INTEGER              | Foreign(departamentos) | S     |
| id_supervisor    | INTERGER             | Foreign(empregados)    | S     |
