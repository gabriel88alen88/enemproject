USE [DW_ENEM]
GO

/****** Object:  StoredProcedure [dbo].[exec_etl]    Script Date: 7/22/2020 10:05:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[exec_etl] 

as

begin 
	insert into staging_enem.dbo.CONTROLE_ETL
	 (dt_inicio,dt_fim)
	 (SELECT GETDATE(), NULL)


	 -- trunca tabelasps: 
	truncate table dimestado
	truncate table dimmunicipio
	truncate table dimEscola
	truncate table dimcandidato
	truncate table dimestado
	truncate table ftibgeestados
	truncate table fatibgemunicipios
	truncate table ftenem

	

-- insert dim estado
insert into dimestado 
(cd_estado  , sg_estado  , ds_estado , ds_capital  ,  dt_inclusao ,  dt_alteracao )
select 
codigo,case WHEN codigo = 12  THEN 'AC'
            WHEN codigo = 27  THEN 'AL'
			WHEN codigo = 16  THEN 'AP'
			WHEN codigo = 13  THEN 'AM'
			WHEN codigo = 29  THEN 'BA'
			WHEN codigo = 23  THEN 'CE'
			WHEN codigo = 53  THEN 'DF'
			WHEN codigo = 32  THEN 'ES'
			WHEN codigo = 52  THEN 'GO'
			WHEN codigo = 21  THEN 'RJ'
			WHEN codigo = 51  THEN 'MT'
			WHEN codigo = 50  THEN 'MS'
			WHEN codigo = 31  THEN 'MG'
			WHEN codigo = 15  THEN 'PA'
			WHEN codigo = 25  THEN 'PB'
			WHEN codigo = 41  THEN 'PN'
			WHEN codigo = 26  THEN 'PE'
			WHEN codigo = 22  THEN 'PI'
			WHEN codigo = 33  THEN 'RJ'
			WHEN codigo = 24  THEN 'RN'
			WHEN codigo = 43  THEN 'RS'
			WHEN codigo = 11  THEN 'RO'
			WHEN codigo = 14  THEN 'RR'
			WHEN codigo = 42  THEN 'SC'
			WHEN codigo = 35  THEN 'SP'
			WHEN codigo = 28  THEN 'SE'
			WHEN codigo = 17  THEN 'TO'
			END AS SIGLA_UF
, uf, capital,getdate(),null  from staging_enem.dbo.estados



-- insert dim municipio

insert into dimmunicipio 
(cd_municipio  , ds_municipio ,  gentilico ,  Lat  , Long  , sk_estado  , dt_inclusao , dt_alteracao )

select MUNICIPIOS.codigo , municipio , gentilico , LAT , LONG  , isnull(dimestado.sk_estado,-1), getdate() , null 
from staging_enem.dbo.municipios as municipios
LEFT JOIN staging_enem.dbo.br_localidades_2010_v1 ON
br_localidades_2010_v1.CD_GEOCODMU = MUNICIPIOS.CODIGO
join dimestado on
dimestado.cd_estado = left (cast(MUNICIPIOS.codigo as varchar(10)),2)
where nm_municipio = NM_LOCALIDADE



-- insert dim escola

insert into dimEscola 
(cd_escola, ds_tipo_escola , ds_tipo_localizacao_escola , ds_tipo_situacao_escola,sk_municipio ,  sk_estado , dt_inclusao , dt_alteracao)

select distinct CO_ESCOLA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_DEPENDENCIA_ADM_ESC' AND CAST(E2017.TP_DEPENDENCIA_ADM_ESC AS VARCHAR(1)) = OPCAO  ) AS DS_TP_DEPENDENCIA_ADM_ESC  ,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_LOCALIZACAO_ESC' AND CAST(E2017.TP_LOCALIZACAO_ESC AS VARCHAR(1)) = OPCAO  ) AS DS_TP_LOCALICAZAO_ESC,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_SIT_FUNC_ESC' AND CAST(E2017.TP_SIT_FUNC_ESC AS VARCHAR(1)) = OPCAO  ) AS DS_TP_SIT_FUNC_ESC
 , isnull (sk_municipio,-1) , isnull (dimestado.sk_estado,-1) ,getdate(),null
from staging_enem.dbo.MICRODADOS_ENEM_2017 E2017 
join dimestado on
dimestado.cd_estado = E2017.CO_UF_ESC
join dimmunicipio on
dimmunicipio.cd_municipio = E2017.CO_MUNICIPIO_ESC
where CO_ESCOLA is not null



-- insert dim candidato

insert into dimcandidato 
     (cd_inscricao   ,      ds_idade ,      ds_sexo,      ds_estado_civil  ,      ds_cor_raca  , ds_nacionalidade, 
     ds_treineiro ,      ds_status_redacao ,  ds_tipo_lingua  ,  ds_cegueira, ds_surdez  , ds_def_auditiva , 
     ds_surdo_cegueira , ds_deficiencia_fisica , ds_deficiencia_mental , ds_deficit_atencao  , 
     ds_dislexia,  ds_discalculia, ds_autismo ,  ds_visao_monocular  , ds_outra_def ,  ds_renda  , 
     ds_moradores_residencia  ,  ds_computador_casa , ds_acesso_internet  , sk_estado_residencia  , 
	 sk_estado_nascimento , sk_municipio_residencia ,  sk_municipio_nascimento ,dt_inclusao ,dt_alteracao  )

SELECT

 NU_INSCRICAO  , NU_IDADE , TP_SEXO ,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_ESTADO_CIVIL' AND CAST(E2017.TP_ESTADO_CIVIL AS VARCHAR(1)) = OPCAO  ) AS DS_ESTADO_CIVIL   ,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_COR_RACA' AND CAST(E2017.TP_COR_RACA AS VARCHAR(1)) = OPCAO  ) AS DS_COR_RACA ,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_NACIONALIDADE' AND CAST(E2017.TP_NACIONALIDADE AS VARCHAR(1)) = OPCAO  ) AS DS_NACIONALIDADE,

(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_TREINEIRO' AND CAST(E2017.IN_TREINEIRO AS VARCHAR(1)) = OPCAO  ) AS DS_IN_TREINEIRO,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_STATUS_REDACAO' AND CAST(E2017.TP_STATUS_REDACAO AS VARCHAR(1)) = OPCAO  ) AS DS_TP_STATUS_REDACAO,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'TP_LINGUA' AND CAST(E2017.TP_LINGUA AS VARCHAR(1)) = OPCAO  ) AS DS_TP_LINGUA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_CEGUEIRA' AND CAST(E2017.IN_CEGUEIRA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_CEGUEIRA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_SURDEZ' AND CAST(E2017.IN_SURDEZ AS VARCHAR(1)) = OPCAO  ) AS DS_IN_SURDEZ,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DEFICIENCIA_AUDITIVA' AND CAST(E2017.IN_DEFICIENCIA_AUDITIVA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_DEFICIENCIA_AUDITIVA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_SURDO_CEGUEIRA' AND CAST(E2017.IN_SURDO_CEGUEIRA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_SURDO_CEGUEIRA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DEFICIENCIA_FISICA' AND CAST(E2017.IN_DEFICIENCIA_FISICA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_DEFICIENCIA_FISICA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DEFICIENCIA_MENTAL' AND CAST(E2017.IN_DEFICIENCIA_MENTAL AS VARCHAR(1)) = OPCAO  ) AS DS_IN_DEFICIENCIA_MENTAL,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DEFICIT_ATENCAO' AND CAST(E2017.IN_DEFICIT_ATENCAO AS VARCHAR(1)) = OPCAO  ) AS IN_DEFICIT_ATENCAO,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DISLEXIA' AND CAST(E2017.IN_DISLEXIA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_DISLEXIA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_DISCALCULIA' AND CAST(E2017.IN_DISCALCULIA AS VARCHAR(1)) = OPCAO  ) AS DS_IN_DISCALCULIA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_AUTISMO' AND CAST(E2017.IN_AUTISMO AS VARCHAR(1)) = OPCAO  ) AS DS_IN_AUTISMO,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_VISAO_MONOCULAR' AND CAST(E2017.IN_VISAO_MONOCULAR AS VARCHAR(1)) = OPCAO  ) AS DS_IN_VISAO_MONOCULAR,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'IN_OUTRA_DEF' AND CAST(E2017.IN_OUTRA_DEF AS VARCHAR(1)) = OPCAO  ) AS DS_IN_OUTRA_DEF,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'Q006' AND CAST(E2017.Q006 AS VARCHAR(1)) = OPCAO  ) AS DS_RENDA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'Q005' AND CAST(E2017.Q005 AS VARCHAR(1)) = OPCAO  ) AS DS_MORADORES_RESIDENCIA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'Q024' AND CAST(E2017.Q024 AS VARCHAR(1)) = OPCAO  ) AS DS_COMPUTADOR_CASA,
(SELECT DESCR FROM staging_enem.dbo.DICIONARIO_DADOS_ENEM_2017 DCE2017 WHERE VARIAVEL LIKE 'Q025' AND CAST(E2017.Q025 AS VARCHAR(1)) = OPCAO  ) AS DS_ACESSO_INTERNET,
isnull(estadoresidencia.sk_estado,-1) ,
isnull(estadonascimento.sk_estado ,-1),
isnull(municipioresidencia.sk_municipio,-1) ,
isnull(municipionascimento.sk_municipio,-1) , getdate() , null 
FROM  staging_enem.dbo.MICRODADOS_ENEM_2017 E2017
left join dimestado as estadoresidencia on
estadoresidencia.cd_estado = E2017.CO_UF_RESIDENCIA
left join dimestado as estadonascimento on
estadonascimento.cd_estado = E2017.CO_UF_NASCIMENTO
left join dimmunicipio  as municipioresidencia on
municipioresidencia.cd_municipio = E2017.CO_MUNICIPIO_RESIDENCIA
left join dimmunicipio  as municipionascimento on
municipionascimento.cd_municipio = E2017.CO_MUNICIPIO_NASCIMENTO



-- insert ft estado

insert into ftibgeestados
    (vl_area_territorial , vl_populacao_estimada , vl_desnsidade_demografica ,  vl_idh , vl_rendimento_mensal_percapta ,  ano_ibge ,  sk_estado )

select area_territorial,populacao_estimada,densidade_demografica,idh,rendimento_mensal_domiciliar_percapta , 2017 ,
sk_estado
 from staging_enem.dbo.estados as fato_ibge_estados
 join dimestado on
 dimestado.cd_estado = fato_ibge_estados.codigo




 -- insert ft municipio

 insert into fatibgemunicipios 
      (  vl_area_territorial, vl_populacao_estimada, vl_densidade_demografica , vl_escolarizacao_6a14anos , vl_idhm  ,
    vl_mortalidade_infantil  , vl_pib_percapta ,    ano_ibge ,    sk_municipio  )

 select  cast (area_territorial as float) , cast (populacao_estimada as int)  , cast (replace(densidade_demografica,'-','') as float), cast (replace(escolarizacao_6a14anos,'-','') as float),
cast (replace(idhm,'-','') as float) , cast (replace(mortalidade_infantil,'-','') as float) , cast (replace(PIB_PERCAPTA,'-','') as float), 2017 as ano_ibge, dimmunicipio.sk_municipio from staging_enem.dbo.municipios as fato_ibge_municipios
 join dimmunicipio on
 dimmunicipio.cd_municipio = fato_ibge_municipios.codigo



-- insert ft enem

insert into dbo.ftenem 
 (vl_nota_ciencias_natureza,vl_nota_ciencias_humanas, vl_nota_linguagens_e_codigos,   vl_nota_matematica,  vl_nota_redacao,   nu_ano_prova,
    sk_candidato,  sk_escola, sk_municipio_prova, sk_estado_prova )

select isnull(E2017.NU_NOTA_CN,0) , isnull(NU_NOTA_CH,0) , isnull(NU_NOTA_LC,0) , isnull(NU_NOTA_MT,0) , isnull(NU_NOTA_REDACAO,0) , NU_ANO AS ANO_PROVA ,sk_candidato , ISNULL(sk_escola,-1) , ISNULL(municipioprova.sk_municipio,-1) , 
ISNULL(estadoprova.sk_estado,-1) 
FROM  staging_enem.dbo.MICRODADOS_ENEM_2017 E2017
JOIN DIMCANDIDATO ON
DIMCANDIDATO.CD_INSCRICAO = E2017.NU_INSCRICAO
left JOIN dimescola ON
dimescola.cd_escola = E2017.CO_ESCOLA 
left join dimestado as estadoprova on
estadoprova.cd_estado = E2017.CO_UF_RESIDENCIA
left join dimmunicipio  as municipioprova on
municipioprova.cd_municipio = E2017.CO_MUNICIPIO_NASCIMENTO


 
DECLARE @ID_EXECUCAO INT
	 SET @ID_EXECUCAO = (SELECT MAX(ID_EXECUCAO) FROM staging_enem.dbo.CONTROLE_ETL)


	 UPDATE staging_enem.dbo.CONTROLE_ETL SET dt_fim = getdate() where id_execucao = @ID_EXECUCAO -- controle de tempo etl


	 end
GO


