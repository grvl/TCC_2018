﻿drop table IF EXISTS dados_fila;

CREATE TABLE dados_fila (
FILA			text,
COORD_SOLICITANTE	text,	
ESTAB_SOLICITANTE	text,	
CNS_PACIENTE		text,
NOME_PACIENTE		text,
NASCIMENTO		date,
IDADE			smallint,
SEXO			text,
MAE_PACIENTE		text,
ENDERECO_PACIENTE	text,
MUNICIPIO		text,
ESTADO			text,
REGIAO			text,
CEP_PACIENTE		text,
ESTAB_VINCULO		text,
REGIÃO			text,
INICIO_TRAT		date,
TRAT_MES		smallint,
TRAT_ANO		text,
DATA_SOLICITACAO	date,
ESPERA_MES		smallint,
PROCEDIMENTO		text,
RESUMO_PROCED		text,
PROCED_RESUMO		text,
CID			text,
CID_2			text,
RESUMO			text,
CATEGORIA		text
);