drop table IF EXISTS tratado.censo_2010_pessoas_geo;
drop table IF EXISTS tratado.censo_2010_domicilios_geo;

SELECT b.geom, CAST(coalesce(a.geocodigo, '0') AS bigint ) as geocodigo, a.municipio, a.distrito, a.area_apuracao,
a.cor_ou_raca, a.dificuldade_enxergar, a.imputacao_dificuldade_enxergar, 
a.dificuldade_ouvir, a.imputacao_dificuldade_ouvir, 
a.dificuldade_caminhar, a.imputacao_dificuldade_caminhar, 
a.deficiencia_intelectual, a.imputacao_deficiencia_intelectual,
b.quantidade_setores
into tratado.censo_2010_pessoas_geo
from (
		select *
		from tratado.censo_2010_dados_pessoas
		WHERE municipio='50308'
     ) as a
join -- não é query, mas é pareamento de 2 consultas
     (
		select geom, area_pond as geocodigo,
		count as quantidade_setores
		FROM importado.ponderacao_dataset_geografico
     ) as b
ON a.geocodigo = b.geocodigo
;

SELECT b.geom, CAST(coalesce(a.geocodigo, '0') AS bigint ) as geocodigo, a.municipio, a.distrito, a.area_apuracao,
a.situacao_domicilio,a.abastecimento_de_agua, a.energia_eletrica, a.renda_domiciliar,
b.quantidade_setores
into tratado.censo_2010_domicilios_geo
from (
		select *
		from tratado.censo_2010_dados_domicilios
		WHERE municipio='50308'
     ) as a
join -- não é query, mas é pareamento de 2 consultas
     (
		select geom, area_pond as geocodigo,
		count as quantidade_setores
		FROM importado.ponderacao_dataset_geografico
     ) as b
ON a.geocodigo = b.geocodigo
;