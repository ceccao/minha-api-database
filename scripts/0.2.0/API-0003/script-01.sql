-- API-0003: Auditoria e controle de concorrencia otimista em PRODUTO
ALTER TABLE PRODUTO
    ADD COLUMN CRIADO_EM DATETIME(6) NOT NULL DEFAULT (UTC_TIMESTAMP(6)) COMMENT 'Data/hora de criação, sempre em UTC',
    ADD COLUMN ATUALIZADO_EM DATETIME(6) NULL COMMENT 'Data/hora da última atualização, sempre em UTC',
    ADD COLUMN VERSION INT NOT NULL DEFAULT 0 COMMENT 'Controle de concorrência otimista (incrementado pela aplicação a cada update)';
