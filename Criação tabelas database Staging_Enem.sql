USE [STAGING_ENEM]
GO
/****** Object:  Table [dbo].[BR_Localidades_2010_v1]    Script Date: 7/22/2020 10:06:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BR_Localidades_2010_v1](
	[ID] [int] NOT NULL,
	[CD_GEOCODIGO] [nvarchar](20) NULL,
	[TIPO] [nvarchar](10) NULL,
	[CD_GEOCODBA] [nvarchar](20) NULL,
	[NM_BAIRRO] [nvarchar](60) NULL,
	[CD_GEOCODSD] [nvarchar](20) NULL,
	[NM_SUBDISTRITO] [nvarchar](60) NULL,
	[CD_GEOCODDS] [nvarchar](20) NULL,
	[NM_DISTRITO] [nvarchar](60) NULL,
	[CD_GEOCODMU] [nvarchar](20) NULL,
	[NM_MUNICIPIO] [nvarchar](60) NULL,
	[NM_MICRO] [nvarchar](100) NULL,
	[NM_MESO] [nvarchar](100) NULL,
	[NM_UF] [nvarchar](60) NULL,
	[CD_NIVEL] [nvarchar](1) NULL,
	[CD_CATEGORIA] [nvarchar](5) NULL,
	[NM_CATEGORIA] [nvarchar](50) NULL,
	[NM_LOCALIDADE] [nvarchar](100) NULL,
	[LONG] [nvarchar](60) NULL,
	[LAT] [nvarchar](60) NULL,
	[ALT] [nvarchar](60) NULL,
	[GM_PONTO_sk] [nvarchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONTROLE_ETL]    Script Date: 7/22/2020 10:06:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROLE_ETL](
	[id_execucao] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[dt_inicio] [datetime] NULL,
	[dt_fim] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DICIONARIO_DADOS_ENEM_2017]    Script Date: 7/22/2020 10:06:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DICIONARIO_DADOS_ENEM_2017](
	[VARIAVEL] [nvarchar](50) NULL,
	[DESC_VARIAVEL] [nvarchar](500) NULL,
	[OPCAO] [nvarchar](10) NULL,
	[DESCR] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 7/22/2020 10:06:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[UF] [nvarchar](19) NULL,
	[CODIGO] [smallint] NULL,
	[GENTILICO] [nvarchar](57) NULL,
	[GOVERNADOR] [nvarchar](40) NULL,
	[CAPITAL] [nvarchar](14) NULL,
	[AREA_TERRITORIAL] [real] NULL,
	[POPULACAO_ESTIMADA] [int] NULL,
	[DENSIDADE_DEMOGRAFICA] [real] NULL,
	[MATRICULAS_ENSINO_FUNDAMENTAL] [int] NULL,
	[IDH] [real] NULL,
	[RECEITAS_REALIZADAS] [numeric](20, 2) NULL,
	[DESPESAS_EMPENHADAS] [numeric](20, 2) NULL,
	[RENDIMENTO_MENSAL_DOMICILIAR_PERCAPTA] [smallint] NULL,
	[TOTAL_VEICULOS] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MICRODADOS_ENEM_2017]    Script Date: 7/22/2020 10:06:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MICRODADOS_ENEM_2017](
	[NU_INSCRICAO] [bigint] NULL,
	[NU_ANO] [smallint] NULL,
	[CO_MUNICIPIO_RESIDENCIA] [int] NULL,
	[NO_MUNICIPIO_RESIDENCIA] [nvarchar](150) NULL,
	[CO_UF_RESIDENCIA] [smallint] NULL,
	[SG_UF_RESIDENCIA] [nvarchar](2) NULL,
	[NU_IDADE] [smallint] NULL,
	[TP_SEXO] [nvarchar](1) NULL,
	[TP_ESTADO_CIVIL] [smallint] NULL,
	[TP_COR_RACA] [smallint] NULL,
	[TP_NACIONALIDADE] [smallint] NULL,
	[CO_MUNICIPIO_NASCIMENTO] [int] NULL,
	[NO_MUNICIPIO_NASCIMENTO] [nvarchar](150) NULL,
	[CO_UF_NASCIMENTO] [smallint] NULL,
	[SG_UF_NASCIMENTO] [nvarchar](2) NULL,
	[TP_ST_CONCLUSAO] [smallint] NULL,
	[TP_ANO_CONCLUIU] [smallint] NULL,
	[TP_ESCOLA] [smallint] NULL,
	[TP_ENSINO] [smallint] NULL,
	[IN_TREINEIRO] [smallint] NULL,
	[CO_ESCOLA] [int] NULL,
	[CO_MUNICIPIO_ESC] [int] NULL,
	[NO_MUNICIPIO_ESC] [nvarchar](150) NULL,
	[CO_UF_ESC] [smallint] NULL,
	[SG_UF_ESC] [nvarchar](2) NULL,
	[TP_DEPENDENCIA_ADM_ESC] [smallint] NULL,
	[TP_LOCALIZACAO_ESC] [smallint] NULL,
	[TP_SIT_FUNC_ESC] [smallint] NULL,
	[IN_BAIXA_VISAO] [smallint] NULL,
	[IN_CEGUEIRA] [smallint] NULL,
	[IN_SURDEZ] [smallint] NULL,
	[IN_DEFICIENCIA_AUDITIVA] [smallint] NULL,
	[IN_SURDO_CEGUEIRA] [smallint] NULL,
	[IN_DEFICIENCIA_FISICA] [smallint] NULL,
	[IN_DEFICIENCIA_MENTAL] [smallint] NULL,
	[IN_DEFICIT_ATENCAO] [smallint] NULL,
	[IN_DISLEXIA] [smallint] NULL,
	[IN_DISCALCULIA] [smallint] NULL,
	[IN_AUTISMO] [smallint] NULL,
	[IN_VISAO_MONOCULAR] [smallint] NULL,
	[IN_OUTRA_DEF] [smallint] NULL,
	[IN_GESTANTE] [smallint] NULL,
	[IN_LACTANTE] [smallint] NULL,
	[IN_IDOSO] [smallint] NULL,
	[IN_ESTUDA_CLASSE_HOSPITALAR] [smallint] NULL,
	[IN_SEM_RECURSO] [smallint] NULL,
	[IN_BRAILLE] [smallint] NULL,
	[IN_AMPLIADA_24] [smallint] NULL,
	[IN_AMPLIADA_18] [smallint] NULL,
	[IN_LEDOR] [smallint] NULL,
	[IN_ACESSO] [smallint] NULL,
	[IN_TRANSCRICAO] [smallint] NULL,
	[IN_LIBRAS] [smallint] NULL,
	[IN_LEITURA_LABIAL] [smallint] NULL,
	[IN_MESA_CADEIRA_RODAS] [smallint] NULL,
	[IN_MESA_CADEIRA_SEPARADA] [smallint] NULL,
	[IN_APOIO_PERNA] [smallint] NULL,
	[IN_GUIA_INTERPRETE] [smallint] NULL,
	[IN_COMPUTADOR] [smallint] NULL,
	[IN_CADEIRA_ESPECIAL] [smallint] NULL,
	[IN_CADEIRA_CANHOTO] [smallint] NULL,
	[IN_CADEIRA_ACOLCHOADA] [smallint] NULL,
	[IN_PROVA_DEITADO] [smallint] NULL,
	[IN_MOBILIARIO_OBESO] [smallint] NULL,
	[IN_LAMINA_OVERLAY] [smallint] NULL,
	[IN_PROTETOR_AURICULAR] [smallint] NULL,
	[IN_MEDIDOR_GLICOSE] [smallint] NULL,
	[IN_MAQUINA_BRAILE] [smallint] NULL,
	[IN_SOROBAN] [smallint] NULL,
	[IN_MARCA_PASSO] [smallint] NULL,
	[IN_SONDA] [smallint] NULL,
	[IN_MEDICAMENTOS] [smallint] NULL,
	[IN_SALA_INDIVIDUAL] [smallint] NULL,
	[IN_SALA_ESPECIAL] [smallint] NULL,
	[IN_SALA_ACOMPANHANTE] [smallint] NULL,
	[IN_MOBILIARIO_ESPECIFICO] [smallint] NULL,
	[IN_MATERIAL_ESPECIFICO] [smallint] NULL,
	[IN_NOME_SOCIAL] [smallint] NULL,
	[CO_MUNICIPIO_PROVA] [int] NULL,
	[NO_MUNICIPIO_PROVA] [nvarchar](150) NULL,
	[CO_UF_PROVA] [smallint] NULL,
	[SG_UF_PROVA] [nvarchar](2) NULL,
	[TP_PRESENCA_CN] [smallint] NULL,
	[TP_PRESENCA_CH] [smallint] NULL,
	[TP_PRESENCA_LC] [smallint] NULL,
	[TP_PRESENCA_MT] [smallint] NULL,
	[CO_PROVA_CN] [smallint] NULL,
	[CO_PROVA_CH] [smallint] NULL,
	[CO_PROVA_LC] [smallint] NULL,
	[CO_PROVA_MT] [smallint] NULL,
	[NU_NOTA_CN] [real] NULL,
	[NU_NOTA_CH] [real] NULL,
	[NU_NOTA_LC] [real] NULL,
	[NU_NOTA_MT] [real] NULL,
	[TX_RESPOSTAS_CN] [nvarchar](45) NULL,
	[TX_RESPOSTAS_CH] [nvarchar](45) NULL,
	[TX_RESPOSTAS_LC] [nvarchar](50) NULL,
	[TX_RESPOSTAS_MT] [nvarchar](45) NULL,
	[TP_LINGUA] [smallint] NULL,
	[TX_GABARITO_CN] [nvarchar](45) NULL,
	[TX_GABARITO_CH] [nvarchar](45) NULL,
	[TX_GABARITO_LC] [nvarchar](50) NULL,
	[TX_GABARITO_MT] [nvarchar](45) NULL,
	[TP_STATUS_REDACAO] [smallint] NULL,
	[NU_NOTA_COMP1] [smallint] NULL,
	[NU_NOTA_COMP2] [smallint] NULL,
	[NU_NOTA_COMP3] [smallint] NULL,
	[NU_NOTA_COMP4] [smallint] NULL,
	[NU_NOTA_COMP5] [smallint] NULL,
	[NU_NOTA_REDACAO] [smallint] NULL,
	[Q001] [nvarchar](1) NULL,
	[Q002] [nvarchar](1) NULL,
	[Q003] [nvarchar](1) NULL,
	[Q004] [nvarchar](1) NULL,
	[Q005] [smallint] NULL,
	[Q006] [nvarchar](1) NULL,
	[Q007] [nvarchar](1) NULL,
	[Q008] [nvarchar](1) NULL,
	[Q009] [nvarchar](1) NULL,
	[Q010] [nvarchar](1) NULL,
	[Q011] [nvarchar](1) NULL,
	[Q012] [nvarchar](1) NULL,
	[Q013] [nvarchar](1) NULL,
	[Q014] [nvarchar](1) NULL,
	[Q015] [nvarchar](1) NULL,
	[Q016] [nvarchar](1) NULL,
	[Q017] [nvarchar](1) NULL,
	[Q018] [nvarchar](1) NULL,
	[Q019] [nvarchar](1) NULL,
	[Q020] [nvarchar](1) NULL,
	[Q021] [nvarchar](1) NULL,
	[Q022] [nvarchar](1) NULL,
	[Q023] [nvarchar](1) NULL,
	[Q024] [nvarchar](1) NULL,
	[Q025] [nvarchar](1) NULL,
	[Q026] [nvarchar](1) NULL,
	[Q027] [nvarchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Municipios]    Script Date: 7/22/2020 10:06:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Municipios](
	[MUNICIPIO] [nvarchar](150) NULL,
	[CODIGO] [int] NULL,
	[GENTILICO] [nvarchar](150) NULL,
	[PREFEITO] [nvarchar](150) NULL,
	[AREA_TERRITORIAL] [nvarchar](50) NULL,
	[POPULACAO_ESTIMADA] [nvarchar](50) NULL,
	[DENSIDADE_DEMOGRAFICA] [nvarchar](50) NULL,
	[ESCOLARIZACAO_6A14ANOS] [nvarchar](50) NULL,
	[IDHM] [nvarchar](50) NULL,
	[MORTALIDADE_INFANTIL] [nvarchar](50) NULL,
	[RECEITAS_REALIZADAS] [nvarchar](50) NULL,
	[DESPESAS_EMPENHADAS] [nvarchar](50) NULL,
	[PIB_PERCAPTA] [nvarchar](50) NULL
) ON [PRIMARY]
GO
