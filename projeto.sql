drop schema projeto;

CREATE DATABASE projeto;

USE projeto;

CREATE TABLE dev(
	login varchar (50) primary key,
    senha varchar (20)
);

CREATE TABLE usuario (
  nome VARCHAR(50),
  login VARCHAR(20) PRIMARY KEY,
  senha VARCHAR(20),
  email varchar(50)
);

CREATE TABLE clientes (
  nome VARCHAR(50) PRIMARY KEY,
  cpf VARCHAR(11),
  telefone VARCHAR(20)
);

CREATE TABLE servico (
  status VARCHAR(20),
  id INT AUTO_INCREMENT PRIMARY KEY,
  endereco VARCHAR(50),
  valor DECIMAL(10,2),
  nome_cliente VARCHAR(50),
  login_usuario VARCHAR(20),
  FOREIGN KEY (nome_cliente) REFERENCES clientes(nome),
  FOREIGN KEY (login_usuario) REFERENCES usuario(login)
);

CREATE TABLE itens (
  id_servico INT,
  itens VARCHAR(50),
  foto BLOB,
  valor_unitario DECIMAL(10,2),
  altura DECIMAL(5,2),
  largura DECIMAL(5,2),
  login_usuario VARCHAR(20),
  PRIMARY KEY (id_servico),
  FOREIGN KEY (id_servico) REFERENCES servico(id),
  FOREIGN KEY (login_usuario) REFERENCES usuario(login)
);

CREATE TABLE pagamento (
  metodo_de_pagamento VARCHAR(20),
  numero_de_parcelas INT,
  id_servico INT PRIMARY KEY,
  FOREIGN KEY (id_servico) REFERENCES servico(id)
);

insert into dev values ('gustavo', '123456');
insert into usuario values ('jorge','jorgingo','jorge123','jorge@jorge.com');

CREATE VIEW clientes_servicos AS
SELECT nome AS nome_cliente, cpf, telefone, id, status, endereco, valor
FROM clientes JOIN servico ON nome = nome_cliente;

select * from clientes_servicos;

CREATE user 'gustavo'@'localhost' identified by '123456';
CREATE user 'jorge'@'localhost' identified by 'jorge123';

GRANT ALL on projeto to 'gustavo'@'localhost';
GRANT CREATE, SELECT, ALTER ON projeto.clientes to 'jorge'@'localhost';
GRANT SELECT ON projeto.clientes_servicos to 'jorge'@'localhost';
