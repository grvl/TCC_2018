drop table IF EXISTS tratado.censo_2010_dados_pessoas;
drop table IF EXISTS tratado.censo_2010_dados_domicilios;

SELECT
p."V0011" as geocodigo,
(
	SUBSTRING(p."V0011",1,2) || -- DF
	'-' ||
	SUBSTRING(p."V0011",3,5) || -- Municipio
	'-' ||
	SUBSTRING(p."V0011",8,2) || -- Distrito
	'-' ||
	SUBSTRING(p."V0011",10,2) || -- SubDistrito
	'-' ||
	SUBSTRING(p."V0011",12,2) -- ponderacao
)
as codigo, SUBSTRING(p."V0011",3,5) as municipio, SUBSTRING(p."V0011",8,4) as distrito, SUBSTRING(p."V0011",12,2) as area_apuracao,
p."V0606" as cor_ou_raca,
p."V0614" as dificuldade_enxergar, p."M0614" as imputacao_dificuldade_enxergar,
p."V0615" as dificuldade_ouvir,  p."M0615" as imputacao_dificuldade_ouvir,
p."V0616" as dificuldade_caminhar,  p."M0616" as imputacao_dificuldade_caminhar,
p."V0617" as deficiencia_intelectual, p."M0617" as imputacao_deficiencia_intelectual
into tratado.censo_2010_dados_pessoas
from importado.censo_2010_pessoas as p;

SELECT
p."V0011" as geocodigo,
(
	SUBSTRING(p."V0011",1,2) || -- DF
	'-' ||
	SUBSTRING(p."V0011",3,5) || -- Municipio
	'-' ||
	SUBSTRING(p."V0011",8,2) || -- Distrito
	'-' ||
	SUBSTRING(p."V0011",10,2) || -- SubDistrito
	'-' ||
	SUBSTRING(p."V0011",12,2) -- ponderacao
)
as codigo, SUBSTRING(p."V0011",3,5) as municipio, SUBSTRING(p."V0011",8,4) as distrito, SUBSTRING(p."V0011",12,2) as area_apuracao,
p."V1006" as situacao_domicilio, p."V0209" as abastecimento_de_agua, p."V0211" as energia_eletrica, p."V6532" as renda_domiciliar
into tratado.censo_2010_dados_domicilios
from importado.censo_2010_domicilios as p;

-- "SITUAÇÃO DO DOMICÍLIO:
-- 1- Urbana
-- 2- Rural"

-- "ABASTECIMENTO DE ÁGUA, CANALIZAÇÃO:
-- 1- Sim, em pelo menos um cômodo
-- 2- Sim, só na propriedade ou terreno
-- 3- Não
-- Branco"

-- "ENERGIA ELÉTRICA, EXISTÊNCIA:
-- 1- Sim, de companhia distribuidora
-- 2- Sim, de outras fontes
-- 3- Não existe energia elétrica
-- Branco"

-- RENDIMENTO DOMICILIAR PER CAPITA, EM Nº DE SALÁRIOS MÍNIMOS, EM JULHO DE 2010

-- "COR OU RAÇA:
-- 1- Branca
-- 2- Preta
-- 3- Amarela
-- 4- Parda
-- 5- Indígena
-- 9- Ignorado"

-- "DIFICULDADE PERMANENTE DE ENXERGAR:
-- 1- Sim, não consegue de modo algum
-- 2- Sim, grande dificuldade
-- 3- Sim, alguma dificuldade
-- 4- Não, nenhuma dificuldade
-- 9- Ignorado"

-- "DIFICULDADE PERMANENTE DE OUVIR:
-- 1- Sim, não consegue de modo algum
-- 2- Sim, grande dificuldade
-- 3- Sim, alguma dificuldade
-- 4- Não, nenhuma dificuldade
-- 9- Ignorado"

-- "DIFICULDADE PERMANENTE DE CAMINHAR OU SUBIR DEGRAUS:
-- 1- Sim, não consegue de modo algum
-- 2- Sim, grande dificuldade
-- 3- Sim, alguma dificuldade
-- 4- Não, nenhuma dificuldade
-- 9- Ignorado"

-- "DEFICIÊNCIA MENTAL/INTELECTUAL PERMANENTE:
-- 1- Sim
-- 2- Não
-- 9- Ignorado"
