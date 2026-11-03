-- API-0001: Criação da tabela produto
CREATE TABLE PRODUTO (
    ID INT NOT NULL AUTO_INCREMENT COMMENT 'Chave primária da tabela',
    NOME VARCHAR(100) NOT NULL COMMENT 'Nome do produto',
    PRECO DECIMAL(18,2) NOT NULL COMMENT 'Preço do produto',
    SITUACAO INT NOT NULL COMMENT 'Status do produto (soft delete: 1 ativo, 0 inativo)',
    PRIMARY KEY (ID)
) COMMENT = 'Armazena os produtos cadastrados';
