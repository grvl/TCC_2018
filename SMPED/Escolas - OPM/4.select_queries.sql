--drop table if exists dados_bpc_filtrados_escola;
--drop table if exists dados_bpc_filtrados_escola_familia;
--drop table if exists dados_bpc_filtrados_escola_mae;

--select distinct b.* into dados_bpc_filtrados_escola from dados_bpc as b inner join 
--join_escolas_bpc_nome_mae_nascimento as j
--ON j.aluno = b.nom_pessoa and j.nasc = b.dta_nasc_pessoa 
--and b.nom_completo_mae_pessoa = j.nome_mae;

--select distinct 
--b.cod_familiar_fam, b.dta_cadastramento_memb, b.dta_atual_memb, b.cod_est_cadastral_memb, b.dat_cadastramento_fam, b.cod_est_cadastral_fam, b.vlr_renda_media_fam, b.faixa_de_renda, b.nom_localidade_fam, b.nom_tip_logradouro_fam, b.nom_titulo_logradouro_fam, b.nom_logradouro_fam, b.num_logradouro_fam, b.des_complemento_fam, b.des_complemento_adic_fam, b.num_cep_logradouro_fam, b.nom_pessoa, b.num_nis_pessoa_atual, j.sexo, b.dta_nasc_pessoa, j.idade, b.cod_parentesco_rf_pessoa, b.nom_completo_mae_pessoa, b.nis_rf, b.cod_deficiencia_memb, b.ind_def_cegueira_memb , b.ind_def_baixa_visao_memb , b.ind_def_surdez_profunda_memb , b.ind_def_surdez_leve_memb , b.ind_def_fisica_memb , b.ind_def_mental_memb , b.ind_def_sindrome_down_memb , b.ind_def_transtorno_mental_memb , b.ind_ajuda_nao_memb , b.ind_ajuda_familia_memb , b.ind_ajuda_especializado_memb , b.ind_ajuda_vizinho_memb, b.ind_ajuda_instituicao_memb , b.ind_ajuda_outra_memb , b.recebe_bolsa_familia, b.valor_bolsa_familia, b.recebe_bpc_rmv, b.especie_beneficio, b.situacao_beneficio, b.regiao, b.lat, b.longi, b.regiao_ibge
--into dados_bpc_filtrados_escola_mae from dados_bpc as b inner join 
--join_escolas_bpc_mae_pessoa as j
--on b.nom_pessoa = j.nome_mae;

--select distinct 
--b.cod_familiar_fam, b.dta_cadastramento_memb, b.dta_atual_memb, b.cod_est_cadastral_memb, b.dat_cadastramento_fam, b.cod_est_cadastral_fam, b.vlr_renda_media_fam, b.faixa_de_renda, b.nom_localidade_fam, b.nom_tip_logradouro_fam, b.nom_titulo_logradouro_fam, b.nom_logradouro_fam, b.num_logradouro_fam, b.des_complemento_fam, b.des_complemento_adic_fam, b.num_cep_logradouro_fam, b.nom_pessoa, b.num_nis_pessoa_atual, j.sexo, b.dta_nasc_pessoa, j.idade, b.cod_parentesco_rf_pessoa, b.nom_completo_mae_pessoa, b.nis_rf, b.cod_deficiencia_memb, b.ind_def_cegueira_memb , b.ind_def_baixa_visao_memb , b.ind_def_surdez_profunda_memb , b.ind_def_surdez_leve_memb , b.ind_def_fisica_memb , b.ind_def_mental_memb , b.ind_def_sindrome_down_memb , b.ind_def_transtorno_mental_memb , b.ind_ajuda_nao_memb , b.ind_ajuda_familia_memb , b.ind_ajuda_especializado_memb , b.ind_ajuda_vizinho_memb, b.ind_ajuda_instituicao_memb , b.ind_ajuda_outra_memb , b.recebe_bolsa_familia, b.valor_bolsa_familia, b.recebe_bpc_rmv, b.especie_beneficio, b.situacao_beneficio, b.regiao, b.lat, b.longi, b.regiao_ibge
--into dados_bpc_filtrados_escola_familia from dados_bpc as b inner join 
--join_escolas_bpc_mae as j
--ON b.nom_completo_mae_pessoa = j.nome_mae;

-------------------------
-- Total
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola where
 --RECEBE_BPC_RMV = 'SIM' and recebe_bolsa_familia is null;

-------------------------
-- Total por genero
--select COD_SEXO_PESSOA, count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola 
--where RECEBE_BPC_RMV = 'SIM' 
--group by COD_SEXO_PESSOA;

--select sexo, count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola_mae 
--where RECEBE_BPC_RMV = 'SIM' 
--group by sexo;

--Ex: Renda por idade
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola_mae 
--where CAST(idade as INT) <= 11
--and CAST(idade as INT) >= 5
--and RECEBE_BPC_RMV = 'SIM';

--Ex: Renda por deficiencia
--select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola_familia where 
--IND_DEF_CEGUEIRA_MEMB is null and 
--IND_DEF_BAIXA_VISAO_MEMB is null and
--IND_DEF_SURDEZ_PROFUNDA_MEMB is null and
--IND_DEF_SURDEZ_LEVE_MEMB is null and
--IND_DEF_FISICA_MEMB =1 and
--IND_DEF_MENTAL_MEMB is null and
--IND_DEF_SINDROME_DOWN_MEMB is null and
--IND_DEF_TRANSTORNO_MENTAL_MEMB is null
--and RECEBE_BPC_RMV = 'SIM';

-------------------------
--Regiao
--select count(*), AVG(VLR_RENDA_MEDIA_FAM), regiao 
--from dados_bpc_filtrados_escola_mae 
--where RECEBE_BPC_RMV = 'SIM' 
--group by regiao order by regiao;
-------------------------

-- Pessoas que recebem ajuda
select count(*), AVG(VLR_RENDA_MEDIA_FAM) from dados_bpc_filtrados_escola_familia 
where 
ind_ajuda_nao_memb is null and
ind_ajuda_familia_memb is null and
ind_ajuda_especializado_memb is null and
ind_ajuda_vizinho_memb is null and
ind_ajuda_instituicao_memb is null and
ind_ajuda_outra_memb is null
and RECEBE_BPC_RMV = 'SIM';
-------------------------
--deficiencia por idade 
--select idade, count(*) from dados_bpc where 
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