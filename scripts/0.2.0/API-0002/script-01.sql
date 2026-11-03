-- API-0002: Criacao da tabela usuario (autenticacao JWT)
CREATE TABLE USUARIO (
    ID INT NOT NULL AUTO_INCREMENT COMMENT 'Chave primária da tabela',
    NOME VARCHAR(100) NOT NULL COMMENT 'Nome do usuário',
    EMAIL VARCHAR(150) NOT NULL COMMENT 'E-mail de login, único, sempre em minúsculas',
    SENHA_HASH VARCHAR(100) NOT NULL COMMENT 'Hash BCrypt da senha (nunca a senha)',
    SITUACAO INT NOT NULL COMMENT 'Status do usuário (1 ativo, 0 inativo)',
    PRIMARY KEY (ID),
    CONSTRAINT UQ_USUARIO_EMAIL UNIQUE (EMAIL)
) COMMENT = 'Armazena os usuários que podem autenticar na API';
