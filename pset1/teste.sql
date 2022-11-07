
CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE hr.cargos IS 'Listagem todos os cargos existentes';
COMMENT ON COLUMN hr.cargos.id_cargo IS 'Chave primária';
COMMENT ON COLUMN hr.cargos.cargo IS 'Nome do cargo';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'Salario minimo do cargo';
COMMENT ON COLUMN hr.cargos.salario_maximo IS 'Salario maximo do cargo';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regioes IS 'Representa principais regiões e continentes. Regiões possuem países';
COMMENT ON COLUMN hr.regioes.id_regiao IS 'Chave primária';
COMMENT ON COLUMN hr.regioes.nome IS 'Nome da região';


CREATE UNIQUE INDEX regioes_idx
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER,
                CONSTRAINT pais_pk PRIMARY KEY (id_pais)
);
COMMENT ON TABLE hr.paises IS 'Representa países. Países ficam em regiões e países possuem localizações.';
COMMENT ON COLUMN hr.paises.id_pais IS 'Chave primária. Sigla de dois caracteres do país
';
COMMENT ON COLUMN hr.paises.nome IS 'nome do pais';
COMMENT ON COLUMN hr.paises.id_regiao IS 'Chave estrangeira referênciando a região do pais';


CREATE UNIQUE INDEX paises_idx
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                uf VARCHAR(25),
                cidade VARCHAR(50),
                cep VARCHAR(12),
                id_pais CHAR(2),
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE hr.localizacoes IS 'Representa localizações. localizações ficam em paises e localizações possuem departamentos.';
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Chave primaria';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Endereço (numero) da localização.';
COMMENT ON COLUMN hr.localizacoes.uf IS 'Estado ou divisão federal onde se situa a localidade';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Nome da cidade';
COMMENT ON COLUMN hr.localizacoes.cep IS 'CEP da localidade';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'Chave estrangeira referênciando o pais da localidade';


CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER,
                id_gerente INTEGER,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departamentos IS 'Representa locais fisicos de trabalho de todos os tipos. Departamentos possuem gerentes encarregados do local.';
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'Chave primária';
COMMENT ON COLUMN hr.departamentos.nome IS 'Nome do departamento';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'Chave estrangeira referênciando a tabela localizacoes';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'Empregado encarregado do departamento. Chave estrangeira para empregados';


CREATE UNIQUE INDEX departamentos_idx
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER,
                id_supervisor INTEGER,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE hr.empregados IS 'Representa empregados. Supervisores e gerentes inclusos.';
COMMENT ON COLUMN hr.empregados.id_empregado IS 'Chave primária';
COMMENT ON COLUMN hr.empregados.nome IS 'Nome completo do empregado';
COMMENT ON COLUMN hr.empregados.email IS 'Email do empregado';
COMMENT ON COLUMN hr.empregados.telefone IS 'Telefone do empregado. Note que essa coluna é do tipo VARCHAR e não simplesmente de tipo INTEGER. por favor não confunda. Dar espaços entre o numero, o códigos de area e o código internacional';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Data de contratação do empregado';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'Cargo do empregado. Chave entrangeira. Cargos são catalogados na tabela cargos. ';
COMMENT ON COLUMN hr.empregados.salario IS 'Salario do funcionario';
COMMENT ON COLUMN hr.empregados.comissao IS 'Porcentagem de comissão do empregado. Apenas válido para empregados do departamento de vendas. Note que essas porcentagens são representadas em frações equivalentes. exemplo: 1.0 equivale a 100%, 0.75 para 75%, 2.0 pra 200%, e assim por diante.';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'Departamento do empregado. Chave estrangeira para departamentos.';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'Supervisor do empregado. auto-relação devido ao fato do supervisor também ser um empregado.';


CREATE UNIQUE INDEX empregados_idx
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER,
                CONSTRAINT historico_pk PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE hr.historico_cargos IS 'Armazena todos os cargos passado de cada empregado. Essa tabela não armazena os cargos atuais de cada empregado. procure pelos cargos de cada empregado na tabela empregados';
COMMENT ON COLUMN hr.historico_cargos.id_empregado IS 'Chave primária';
COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'Data inicial do empregado naquele certo cargo';
COMMENT ON COLUMN hr.historico_cargos.data_final IS 'Data do fim do empragado naquele cargo';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'Cargo em que o funcionario foi empregado. Chave estrangeira para cargos.';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'Departamento onde o funcionario exercia o cargo. Chave estrangeira para departamentos.';


ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
