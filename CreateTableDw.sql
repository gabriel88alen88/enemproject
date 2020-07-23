/*
DROP TABLE DBO.DIMESTADO
DROP TABLE DBO.DIMESCOLA
DROP TABLE DBO.DIMMUNICIPIO
DROP TABLE DBO.dimcandidato 
DROP TABLE DBO.FTENEM
DROP TABLE FATIBGEMUNICIPIOS
DROP TABLE FTIBGEESTADOS
*/
-- create table dimensao estado
CREATE TABLE dbo.dimestado 
    ( sk_estado INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     cd_estado INTEGER , 
     sg_estado VARCHAR (2) , 
     ds_estado VARCHAR (50) , 
     ds_capital VARCHAR (50) , 
     dt_inclusao DATETIME , 
     dt_alteracao DATETIME 
    )
GO 


CREATE nonclustered index dimestado_i_1 ON dbo.dimestado ( sk_estado ) 
go

ALTER TABLE dbo.dimestado ADD constraint dimestado_pk PRIMARY KEY CLUSTERED (sk_estado)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
	 
go

SET IDENTITY_INSERT dimestado on

insert into dimestado 
(sk_estado , cd_estado  , sg_estado  , ds_estado , ds_capital  ,  dt_inclusao ,  dt_alteracao )
values
( -1, -1 ,  'ND' , 'Não preenchido' ,'Não preenchido' , getdate() , null )

SET IDENTITY_INSERT dimestado off


-- create table dimmunicipio


CREATE TABLE dbo.dimmunicipio 
    ( sk_municipio INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     cd_municipio INTEGER , 
     ds_municipio VARCHAR (150) , 
     gentilico VARCHAR (50) , 
     Lat VARCHAR (50) , 
     Long VARCHAR (50) , 
     sk_estado INTEGER NOT NULL , 
     dt_inclusao DATETIME , 
     dt_alteracao DATETIME 
    )
GO 


CREATE nonclustered index dimmunicipio_i_1 ON dbo.dimmunicipio ( sk_municipio
) 
go

ALTER TABLE dbo.dimmunicipio ADD constraint dimmunicipio_pk PRIMARY KEY CLUSTERED (sk_municipio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
go

SET IDENTITY_INSERT dimmunicipio on

insert into dimmunicipio 
(sk_municipio  , cd_municipio  , ds_municipio ,  gentilico ,  Lat  , Long  , sk_estado  , dt_inclusao , dt_alteracao )
values
( -1, -1  , 'Não preenchido' ,'Não preenchido' , 'Não preenchido' , 'Não preenchido'  ,-1, getdate() , null )

SET IDENTITY_INSERT dimmunicipio off

-- create table dimensao escola
create TABLE dbo.dimescola 
    ( sk_escola INTEGER NOT NULL IDENTITY , 
	 cd_escola integer not null ,
     ds_tipo_escola VARCHAR (20) , 
     ds_tipo_localizacao_escola VARCHAR (20) , 
     ds_tipo_situacao_escola VARCHAR (30) , 
     sk_municipio INTEGER NOT NULL , 
     sk_estado INTEGER NOT NULL , 
     dt_inclusao DATETIME , 
     dt_alteracao DATETIME 
    )
GO 


CREATE nonclustered index dimescola_i_1 ON dbo.dimescola ( sk_escola ) 

go

ALTER TABLE dbo.dimescola ADD constraint dimescola_pk PRIMARY KEY CLUSTERED (sk_Escola)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
	 
	 go

SET IDENTITY_INSERT dimEscola on

insert into dimEscola 
(sk_escola ,cd_escola, ds_tipo_escola , ds_tipo_localizacao_escola , ds_tipo_situacao_escola,sk_municipio ,  sk_estado , dt_inclusao , dt_alteracao)
values
( -1,-1 ,'Não preenchido' ,  'Não preenchido' , 'Não preenchido' ,-1 , -1 , getdate() , null )

SET IDENTITY_INSERT dimEscola off

-- create table dim candidato

CREATE TABLE dbo.dimcandidato 
    (
    sk_candidato   bigint NOT NULL  IDENTITY NOT FOR REPLICATION ,
    cd_inscricao   bigint NOT NULL, 
     ds_idade INTEGER , 
     ds_sexo VARCHAR (1) , 
     ds_estado_civil VARCHAR (50) , 
     ds_cor_raca VARCHAR (50) , 
     ds_nacionalidade VARCHAR (50) , 
     ds_treineiro VARCHAR (3) , 
     ds_status_redacao VARCHAR (50) , 
     ds_tipo_lingua VARCHAR (50) , 
     ds_cegueira VARCHAR (3) , 
     ds_surdez VARCHAR (3) , 
     ds_def_auditiva VARCHAR (3) , 
     ds_surdo_cegueira VARCHAR (3) , 
     ds_deficiencia_fisica VARCHAR (3) , 
     ds_deficiencia_mental VARCHAR (3) , 
     ds_deficit_atencao VARCHAR (3) , 
     ds_dislexia VARCHAR (3) , 
     ds_discalculia VARCHAR (3) , 
     ds_autismo VARCHAR (3) , 
     ds_visao_monocular VARCHAR (3) , 
     ds_outra_def VARCHAR (3) , 
     ds_renda VARCHAR (150) , 
     ds_moradores_residencia VARCHAR (50) , 
     ds_computador_casa VARCHAR (50) , 
     ds_acesso_internet VARCHAR (5) , 
     sk_estado_residencia INTEGER NOT NULL , 
     sk_estado_nascimento INTEGER NOT NULL , 
     sk_municipio_residencia INTEGER NOT NULL , 
     sk_municipio_nascimento INTEGER NOT NULL,
dt_inclusao datetime,
dt_alteracao datetime )
GO

ALTER TABLE dbo.dimcandidato ADD constraint dimcandidato_pk PRIMARY KEY CLUSTERED (sk_candidato)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
go

SET IDENTITY_INSERT dimcandidato off


CREATE TABLE dbo.fatibgemunicipios (
    vl_area_territorial         FLOAT,
    vl_populacao_estimada       INTEGER,
    vl_densidade_demografica    FLOAT,
    vl_escolarizacao_6a14anos   FLOAT,
    vl_idhm                     FLOAT,
    vl_mortalidade_infantil     FLOAT,
    vl_pib_percapta             FLOAT,
    ano_ibge                    INTEGER,
    sk_municipio                INTEGER NOT NULL
)

go 


CREATE nonclustered index fatibgemunicipios_i_1 ON dbo.fatibgemunicipios ( sk_municipio ) 
go

create TABLE dbo.ftenem (
    vl_nota_ciencias_natureza      NUMERIC(6, 2),
    vl_nota_ciencias_humanas       NUMERIC(6, 2),
    vl_nota_linguagens_e_codigos   NUMERIC(6, 2),
    vl_nota_matematica             NUMERIC(6, 2),
    vl_nota_redacao                NUMERIC(6, 2),
    nu_ano_prova                   INTEGER,
    sk_candidato                   bigint NOT NULL,
    sk_escola                      INTEGER NOT NULL,
    sk_municipio_prova             INTEGER NOT NULL,
    sk_estado_prova                INTEGER NOT NULL
)

go 

    
CREATE nonclustered index ftenem_i_1 ON dbo.ftenem(sk_candidato, sk_escola, sk_municipio_prova, sk_estado_prova)
 go

create TABLE dbo.ftibgeestados (
    vl_area_territorial             NUMERIC(28, 4),
    vl_populacao_estimada           bigint,
    vl_desnsidade_demografica       NUMERIC(10, 2),
    vl_idh                          NUMERIC(10, 3),
    vl_rendimento_mensal_percapta   NUMERIC(10, 2),
    ano_ibge                        INTEGER,
    sk_estado                       INTEGER NOT NULL
)

go 

    
CREATE nonclustered index ftibgeestados_i_1 ON dbo.ftibgeestados ( sk_estado ) 
go



-- ADD FKS
/*
ALTER TABLE dbo.ftEnem
    ADD CONSTRAINT dimcandidato_ftenem_fk_1 FOREIGN KEY ( sk_candidato )
        REFERENCES dbo.dimcandidato ( sk_candidato )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.ftEnem
    ADD CONSTRAINT dimescola_ftenem_fk_2 FOREIGN KEY ( sk_escola )
        REFERENCES dbo.dimescola ( sk_escola )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimCandidato
    ADD CONSTRAINT dimestado_dimcandidato_fk_1 FOREIGN KEY ( sk_estado_residencia )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimCandidato
    ADD CONSTRAINT dimestado_dimcandidato_fk_3 FOREIGN KEY ( sk_estado_nascimento )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimEscola
    ADD CONSTRAINT dimestado_dimescola_fk_2 FOREIGN KEY ( sk_estado )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimMunicipio
    ADD CONSTRAINT dimestado_dimmunicipio_fk_1 FOREIGN KEY ( sk_estado )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.ftEnem
    ADD CONSTRAINT dimestado_ftenem_fk_4 FOREIGN KEY ( sk_estado_prova )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.ftIbgeEstados
    ADD CONSTRAINT dimestado_ftibgeestados_fk_1 FOREIGN KEY ( sk_estado )
        REFERENCES dbo.dimestado ( sk_estado )
ON DELETE NO ACTION 
    ON UPDATE no action
	 go

ALTER TABLE dbo.dimCandidato
    ADD CONSTRAINT dimmunicipio_dimcandidato_fk_3 FOREIGN KEY ( sk_municipio_residencia )
        REFERENCES dbo.dimmunicipio ( sk_municipio )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimCandidato
    ADD CONSTRAINT dimmunicipio_dimcandidato_fk_5 FOREIGN KEY ( sk_municipio_nascimento )
        REFERENCES dbo.dimmunicipio ( sk_municipio )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

ALTER TABLE dbo.dimEscola
    ADD CONSTRAINT dimmunicipio_dimescola_fk_1 FOREIGN KEY ( sk_municipio )
        REFERENCES dbo.dimmunicipio ( sk_municipio )
ON DELETE NO ACTION 
    ON UPDATE no action
	 go

ALTER TABLE dbo.fatIbgeMunicipios
    ADD CONSTRAINT dimmunicipio_fatibgemunicipios_fk_1 FOREIGN KEY ( sk_municipio )
        REFERENCES dbo.dimmunicipio ( sk_municipio )
ON DELETE NO ACTION 
    ON UPDATE no action
	 go

ALTER TABLE dbo.ftEnem
    ADD CONSTRAINT dimmunicipio_ftenem_fk_3 FOREIGN KEY ( sk_municipio_prova )
        REFERENCES dbo.dimmunicipio ( sk_municipio )
ON DELETE NO ACTION 
    ON UPDATE no action 
	go

*/