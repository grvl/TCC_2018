drop table IF EXISTS tratado.censo_2010_deficiencia_por_geocodigo;
-- drop table IF EXISTS tratado.censo_2010_imputacao_deficiencia_por_geocodigo;

select geocodigo,
count(case when dificuldade_enxergar = '1' OR dificuldade_enxergar = '2' OR dificuldade_enxergar = '3' then 1 else null end) as dificuldade_enxergar,
count(case when dificuldade_ouvir = '1' OR dificuldade_ouvir = '2' OR dificuldade_ouvir = '3' then 1 else null end) as dificuldade_ouvir,
count(case when dificuldade_caminhar = '1' OR dificuldade_caminhar = '2' OR dificuldade_caminhar = '3' then 1 else null end) as dificuldade_caminhar,
count(case when deficiencia_intelectual = '1' then 1 else null end) as deficiencia_intelectual,
count(case when dificuldade_enxergar = '1' OR dificuldade_enxergar = '2' OR dificuldade_enxergar = '3' OR
                dificuldade_ouvir = '1' OR dificuldade_ouvir = '2' OR dificuldade_ouvir = '3' OR
                dificuldade_caminhar = '1' OR dificuldade_caminhar = '2' OR dificuldade_caminhar = '3'  OR
                deficiencia_intelectual = '1' then 1 else null end) as total_dificuldade,
count(case when dificuldade_enxergar = ' ' then null else 1 end) as total_contavel,
count(*) as total
into tratado.censo_2010_deficiencia_por_geocodigo
from tratado.censo_2010_pessoas_geo group by geocodigo;
--
-- select geocodigo,
-- count(case when imputacao_dificuldade_enxergar = '1' then 1 else null end) as dificuldade_enxergar,
-- count(case when imputacao_dificuldade_ouvir = '1' then 1 else null end) as dificuldade_ouvir,
-- count(case when imputacao_dificuldade_caminhar = '1' then 1 else null end) as dificuldade_caminhar,
-- count(case when imputacao_deficiencia_intelectual = '1' then 1 else null end) as deficiencia_intelectual,
-- count(*) as total
-- into tratado.censo_2010_imputacao_deficiencia_por_geocodigo
-- from tratado.censo_2010_pessoas_geo group by geocodigo;
