-- Total por genero
--select COD_SEXO_PESSOA, count(*) from dados_bpc where RECEBE_BPC_RMV = 'SIM' group by COD_SEXO_PESSOA;

-------------------------

-- Total por idade
-- Ex: 5 a 11 anos
-- select count(*) from dados_bpc where IDADE >= 31 AND IDADE <= 50 AND RECEBE_BPC_RMV = 'SIM';

-------------------------
-- Porcentagem por tipo de deficiencia
-- Ex: Total de pessoas com deficiencia transtorno mental
--select count(*) from dados_bpc where 
--IND_DEF_CEGUEIRA_MEMB is null and 
--IND_DEF_BAIXA_VISAO_MEMB is null and
--IND_DEF_SURDEZ_PROFUNDA_MEMB is null and
--IND_DEF_SURDEZ_LEVE_MEMB is null and
--IND_DEF_FISICA_MEMB is null and
--IND_DEF_MENTAL_MEMB is null and
--IND_DEF_SINDROME_DOWN_MEMB is null and
--IND_DEF_TRANSTORNO_MENTAL_MEMB =1
--AND RECEBE_BPC_RMV = 'SIM';

-------------------------
-- Beneficiários por bairro/região
--select NOM_LOCALIDADE_FAM, count(*) from dados_bpc group by NOM_LOCALIDADE_FAM ORDER BY NOM_LOCALIDADE_FAM;

-------------------------
-- Ex: Renda Media por genero
--select COD_SEXO_PESSOA, AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc where RECEBE_BPC_RMV = 'SIM' group by COD_SEXO_PESSOA;

--Ex: Renda por idade
--select AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc where IDADE>= 51 AND IDADE <= 64 and RECEBE_BPC_RMV = 'SIM';

--Ex: Renda por deficiencia
--select AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc where 
--IND_DEF_CEGUEIRA_MEMB is null and 
--IND_DEF_BAIXA_VISAO_MEMB is null and
--IND_DEF_SURDEZ_PROFUNDA_MEMB is null and
--IND_DEF_SURDEZ_LEVE_MEMB is null and
--IND_DEF_FISICA_MEMB is null and
--IND_DEF_MENTAL_MEMB is null and
--IND_DEF_SINDROME_DOWN_MEMB is null and
--IND_DEF_TRANSTORNO_MENTAL_MEMB =1
--and RECEBE_BPC_RMV = 'SIM';

-------------------------

-- Pessoas que recebem ajuda
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc where IND_AJUDA_INSTITUICAO_MEMB = 1 and RECEBE_BPC_RMV = 'SIM';

-------------------------
--deficiencia por idade
select idade, count(*) from dados_bpc where 
IND_DEF_CEGUEIRA_MEMB is null and 
IND_DEF_BAIXA_VISAO_MEMB is null and
IND_DEF_SURDEZ_PROFUNDA_MEMB is null and
IND_DEF_SURDEZ_LEVE_MEMB =1 and
IND_DEF_FISICA_MEMB is null and
IND_DEF_MENTAL_MEMB is null and
IND_DEF_SINDROME_DOWN_MEMB is null and
IND_DEF_TRANSTORNO_MENTAL_MEMB is null
AND RECEBE_BPC_RMV = 'SIM'

group by IDADE order by IDADE ASC;