-- API-0001: Criação da tabela produto
CREATE TABLE produto (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Chave primária da tabela',
    nome VARCHAR(100) NOT NULL COMMENT 'Nome do produto',
    preco DECIMAL(18,2) NOT NULL COMMENT 'Preço do produto',
    ativo BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Status do produto (soft delete: 1 ativo, 0 inativo)',
    criado_em DATETIME(6) NOT NULL COMMENT 'Data/hora de criação, sempre em UTC',
    atualizado_em DATETIME(6) NULL COMMENT 'Data/hora da última atualização, sempre em UTC',
    version INT NOT NULL DEFAULT 0 COMMENT 'Controle de concorrência otimista (NHibernate)',
    PRIMARY KEY (id)
) COMMENT = 'Armazena os produtos cadastrados';
