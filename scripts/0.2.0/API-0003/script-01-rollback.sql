-- Rollback do API-0003/script-01: remove as colunas de auditoria e versao
ALTER TABLE PRODUTO
    DROP COLUMN CRIADO_EM,
    DROP COLUMN ATUALIZADO_EM,
    DROP COLUMN VERSION;
