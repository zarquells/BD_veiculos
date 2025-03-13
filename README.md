# Banco de Dados RentVehicles - PostgreSQL

Este repositório contém os scripts para criar e 'brincar' com um banco de dados em PostgreSQL. Feito em aula.

## Requisitos
- [PostgreSQL](https://www.postgresql.org/download/) instalado nativamente no desktop
- [psql](https://www.postgresql.org/download/) configurado no PATH
- [PostgreSQL](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-postgresql) biblioteca instalada no VStudio

## Como Executar Localmente

1. **Clone o repositório:**
   ```sh
   git clone https://github.com/zarquells/BD_veiculos
   cd BD_veiculos
   ```

2. **Crie o banco de dados:**
   ```sh
   psql -U seu_usuario -c "CREATE DATABASE db_rentvehicles;"
   ```

3. **Execute os scripts SQL:**
   ```sh
   psql -U seu_usuario -d db_rentvehicles -f query_tables.sql
   psql -U seu_usuario -d db_rentvehicles -f query_fill.sql
   psql -U seu_usuario -d db_rentvehicles -f query_selects.sql
   ```

4. **Verifique a conexão:**
   ```sh
   psql -U seu_usuario -d db_rentvehicles
   ```

## Estrutura do Repositório
- `query_tables.sql` - Cria as tabelas e estruturas do banco
- `query_fill.sql` - Insere dados iniciais
- `query_selects.sql` - Exemplos de consultas