-- para facilitar, ja coloca os dados de deficiencia desde o comeco
drop table IF EXISTS tratado.dados_IBGE;
SELECT * INTO tratado.dados_IBGE
FROM tratado.ponderacao_dataset_geografico
NATURAL JOIN tratado.censo_2010_deficiencia_por_geocodigo;
