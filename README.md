# minha-api-database

Schema do banco da MinhaApi, versionado com **Liquibase** em SQL puro. É o **único dono do schema**: o backend (EF Core) só lê o que está aqui, sem `dotnet ef migrations`.

## Pré-requisitos

| Ferramenta | Observação |
|---|---|
| Java 17+ | O Liquibase depende dele |
| Liquibase CLI 5.x | `winget install --id Liquibase.Liquibase -e` |
| Driver MySQL | O Liquibase 5 não traz nenhum: `liquibase lpm add mysql --global` |
| MySQL 8.x | Nativo no Windows ou em Docker |

## Primeira configuração

1. Crie o banco em UTC e utf8mb4:
   ```sql
   CREATE DATABASE minha_api_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```
   No `my.ini` (seção `[mysqld]`) use `default-time-zone='+00:00'`.
2. Copie `liquibase.dev.properties.example` para `liquibase.dev.properties` e preencha a senha. Esse arquivo está no `.gitignore`, **nunca o versione**.

## Comandos do dia a dia

```bash
liquibase --defaultsFile=liquibase.dev.properties status
liquibase --defaultsFile=liquibase.dev.properties update
liquibase --defaultsFile=liquibase.dev.properties rollback-count 1
liquibase --defaultsFile=liquibase.dev.properties history
```

## Como criar uma mudança de schema

1. Crie `scripts/{versão}/{TICKET}/script-01.sql` **e** `script-01-rollback.sql` (o rollback é escrito à mão).
2. Crie ou edite `changelogs/minha-api.changelog-{versão}.xml` com um `<changeSet>` apontando para os dois via `<sqlFile>`, e inclua-o no `minha-api.changelog-master.xml`.
3. Teste: `update`, depois `rollback-count 1`, depois `update` de novo.
4. No backend, ajuste a `IEntityTypeConfiguration` da entidade **no mesmo ticket**. O EF Core não valida o schema na subida: nome de coluna divergente só estoura na primeira query.

## Regras

- **Nunca edite um script já aplicado.** O Liquibase guarda o checksum e passa a falhar com "Checksum changed". Crie um script novo.
- **Respeite a caixa dos nomes de tabela e coluna** (hoje em maiúsculas, como `PRODUTO`). No MySQL em Linux, `produto` e `PRODUTO` são tabelas diferentes, e o CI roda em Linux.
- Todo script tem rollback. O CI aplica, desfaz e reaplica para provar que o rollback funciona.

## Ambientes

`main` = produção, `hml` = homologação, `dev` = desenvolvimento. Os arquivos `liquibase.hml/prod.properties.example` ficam adormecidos até o deploy na Azure ser ativado.
