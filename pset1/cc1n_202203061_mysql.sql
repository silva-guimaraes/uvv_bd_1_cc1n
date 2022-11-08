create database hr;

use hr;

CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

/*ALTER TABLE cargos COMMENT 'Listagem todos os cargos existentes';*/

/*ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Chave primária';*/

/*ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Nome do cargo';*/

/*ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'Salario minimo do cargo';*/

/*ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'Salario maximo do cargo';*/


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE regioes (
                id_regiao INT AUTO_INCREMENT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

/*ALTER TABLE regioes COMMENT 'Representa principais regiões e continentes. Regiões possuem países';*/

/*ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave primária';*/

/*ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Nome da região';*/


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                id_regiao INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_pais, id_regiao)
);

/*ALTER TABLE paises COMMENT 'Representa países. Países ficam em regiões e países possuem localizações.';*/

/*ALTER TABLE paises MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave primária. Sigla de dois caracteres do país';*/

/*ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira referênciando a região do pais';*/

/*ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'nome do pais';*/


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT AUTO_INCREMENT NOT NULL,
                id_pais CHAR(2) NOT NULL,
                id_regiao INT NOT NULL,
                endereco VARCHAR(50),
                uf VARCHAR(25),
                cidade VARCHAR(50),
                cep VARCHAR(12),
                PRIMARY KEY (id_localizacao, id_pais, id_regiao)
);

/*ALTER TABLE localizacoes COMMENT 'Representa localizações. localizações ficam em paises e localizações possuem departamentos.';*/

/*ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave primaria';*/

/*ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira referênciando o pais da localidade';*/

/*ALTER TABLE localizacoes MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira referênciando a região do pais';*/

/*ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço (numero) da localização.';*/

/*ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado ou divisão federal onde se situa a localidade';*/

/*ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Nome da cidade';*/

/*ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP da localidade';*/


CREATE TABLE departamentos (
                id_departamento INT AUTO_INCREMENT NOT NULL,
                id_localizacao INT NOT NULL,
                id_pais CHAR(2) NOT NULL,
                id_regiao INT NOT NULL,
                nome VARCHAR(50),
                id_gerente INT,
                PRIMARY KEY (id_departamento, id_localizacao, id_pais, id_regiao)
);

/*ALTER TABLE departamentos COMMENT 'Representa locais fisicos de trabalho de todos os tipos. Departamentos possuem gerentes encarregados do local.';*/

/*ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Chave primária';*/

/*ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira referênciando a tabela localizacoes';*/

/*ALTER TABLE departamentos MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira referênciando o pais da localidade';*/

/*ALTER TABLE departamentos MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira referênciando a região do pais';*/

/*ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do departamento';*/

/*ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'Empregado encarregado do departamento. Chave estrangeira para empregados';*/


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregado INT AUTO_INCREMENT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(4,2),
                id_departamento INT NOT NULL,
                id_supervisor INT,
                id_localizacao INT NOT NULL,
                id_pais CHAR(2) NOT NULL,
                id_regiao INT NOT NULL,
                PRIMARY KEY (id_empregado)
);

/*ALTER TABLE empregados COMMENT 'Representa empregados. Supervisores e gerentes inclusos.';*/

/*ALTER TABLE empregados MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária';*/

/*ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome completo do empregado';*/

/*ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'Email do empregado';*/

/*ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'Telefone do empregado. Note que essa coluna é do tipo VARCHAR e não simplesmente de tipo INTEGER. por favor não confunda. Dar espaços entre o numero, o códigos de area e o código internacional';*/

/*ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Data de contratação do empregado';*/

/*ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Cargo do empregado. Chave entrangeira. Cargos são catalogados na tabela cargos.';*/

/*ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Salario do funcionario';*/

/*ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4, 2) COMMENT 'Porcentagem de comissão do empregado. Apenas válido para empregados do departamento de vendas. Note que essas porcentagens são representadas em frações equivalentes. exemplo: 1.0 equivale a 100%, 0.75 para 75%, 2.0 pra 200%, e assim por diante.';*/

/*ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'Departamento do empregado. Chave estrangeira para departamentos.';*/

/*ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Supervisor do empregado. auto-relação devido ao fato do supervisor também ser um empregado.';*/

/*ALTER TABLE empregados MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira referênciando a tabela localizacoes';*/

/*ALTER TABLE empregados MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira referênciando o pais da localidade';*/

/*ALTER TABLE empregados MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira referênciando a região do pais';*/


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE TABLE historico_cargos (
                id_empregado INT AUTO_INCREMENT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                id_localizacao INT NOT NULL,
                id_pais CHAR(2) NOT NULL,
                id_regiao INT NOT NULL,
                PRIMARY KEY (id_empregado, data_inicial)
);

/*ALTER TABLE historico_cargos COMMENT 'Armazena todos os cargos passado de cada empregado. Essa tabela não armazena os cargos atuais de cada empregado. procure pelos cargos de cada empregado na tabela empregados';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_empregado INTEGER COMMENT 'Chave primária';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Data inicial do empregado naquele certo cargo';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN data_final DATE COMMENT 'Data do fim do empragado naquele cargo';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Cargo em que o funcionario foi empregado. Chave estrangeira para cargos.';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'Departamento onde o funcionario exercia o cargo. Chave estrangeira para departamentos.';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Chave estrangeira referênciando a tabela localizacoes';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_pais CHAR(2) COMMENT 'Chave estrangeira referênciando o pais da localidade';*/

/*ALTER TABLE historico_cargos MODIFY COLUMN id_regiao INTEGER COMMENT 'Chave estrangeira referênciando a região do pais';*/


ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais, id_regiao)
REFERENCES paises (id_pais, id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_regiao, id_pais, id_localizacao)
REFERENCES localizacoes (id_regiao, id_pais, id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento, id_localizacao, id_pais, id_regiao)
REFERENCES departamentos (id_departamento, id_localizacao, id_pais, id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento, id_localizacao, id_pais, id_regiao)
REFERENCES departamentos (id_departamento, id_localizacao, id_pais, id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
