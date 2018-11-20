DROP TABLE IF EXISTS importado.ponderacao_dataset_geografico;

SELECT c.geom,  c.area_pond, c.count

into importado.ponderacao_dataset_geografico
FROM 
(

SELECT DISTINCT ON (a.area_pond) geom, a.area_pond, b.feicoes_duplicadas, a.id, a.count
from (	
	select area_pond,
	geom, id, count
	from public.shp_35see250gc_sir_area_de_ponderacao
	order by area_pond
	ASC
     ) as a 
join -- não é query, mas é pareamento de 2 consultas
     (
	-- Query no. 2 - Contagem de feições duplicadas
	SELECT area_pond, count(*) AS feicoes_duplicadas FROM public.shp_35see250gc_sir_area_de_ponderacao
	GROUP BY 1 
	ORDER BY area_pond
     ) as b 
ON a.area_pond = b.area_pond ) AS c order by feicoes_duplicadas;
