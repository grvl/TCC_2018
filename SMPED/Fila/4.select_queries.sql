--drop table if exists dados_bpc_filtrados_fila;

--select b.*
--into dados_bpc_filtrados_fila from dados_bpc as b inner join join_fila_bpc_nome_mae_nascimento as j
--ON j.nome_paciente = b.nom_pessoa and j.nascimento = b.dta_nasc_pessoa 
--and b.nom_completo_mae_pessoa = j.mae_paciente;


--select nom_pessoa, count(*) from dados_bpc_filtrados_fila group by nom_pessoa having count(nom_pessoa) > 1;
--select * from dados_bpc_filtrados_fila order by nom_pessoa;

-------------------------
-- Beneficiários por bairro/região
--select NOM_LOCALIDADE_FAM, count(*) from dados_bpc_filtrados_fila group by NOM_LOCALIDADE_FAM ORDER BY NOM_LOCALIDADE_FAM;

-------------------------
-- Ex: Renda Media por genero
--select COD_SEXO_PESSOA, count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_fila 
--where RECEBE_BPC_RMV = 'SIM' 
--group by COD_SEXO_PESSOA;

--Ex: Renda por idade
--select AVG(VLR_RENDA_MEDIA_FAM), count(*) from dados_bpc_filtrados_fila 
--where  IDADE >= 65 AND IDADE <= 999
--and RECEBE_BPC_RMV = 'SIM';

--Ex: Renda por deficiencia
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_fila where 
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
-- Bolsa familia
-- select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_fila where recebe_bolsa_familia  ='SIM' and RECEBE_BPC_RMV is null;
-------------------------

-- Pessoas que recebem ajuda
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_fila where IND_AJUDA_INSTITUICAO_MEMB = 1 and RECEBE_BPC_RMV = 'SIM';

-------------------------
--deficiencia por idade
--select idade, count(*) from dados_bpc_filtrados_fila where 
--IND_DEF_CEGUEIRA_MEMB is null and 
--IND_DEF_BAIXA_VISAO_MEMB is null and
--IND_DEF_SURDEZ_PROFUNDA_MEMB is null and
--IND_DEF_SURDEZ_LEVE_MEMB =1 and
--IND_DEF_FISICA_MEMB is null and
--IND_DEF_MENTAL_MEMB is null and
--IND_DEF_SINDROME_DOWN_MEMB is null and
--IND_DEF_TRANSTORNO_MENTAL_MEMB is null
--AND RECEBE_BPC_RMV = 'SIM'
--group by IDADE order by IDADE ASC;