drop table if exists join_fila_bpc_nome_mae_nascimento;
drop table if exists join_fila_bpc_nome_mae_nascimento_cns;

select distinct f.nome_paciente, f.nascimento, f.mae_paciente
into join_fila_bpc_nome_mae_nascimento from dados_bpc as b inner join dados_fila as f 
ON f.nome_paciente = b.nom_pessoa and f.nascimento = b.dta_nasc_pessoa 
and b.nom_completo_mae_pessoa = f.mae_paciente;

select distinct f.nome_paciente, f.nascimento, f.mae_paciente, f.cns_paciente
into join_fila_bpc_nome_mae_nascimento_cns from dados_bpc as b inner join dados_fila as f 
ON f.nome_paciente = b.nom_pessoa and f.nascimento = b.dta_nasc_pessoa 
and b.nom_completo_mae_pessoa = f.mae_paciente;


drop table if exists join_fila_bpc_nome_nascimento;
drop table if exists join_fila_bpc_nome_nascimento_cns;

select distinct f.nome_paciente, f.nascimento
into join_fila_bpc_nome_nascimento from dados_bpc as b inner join dados_fila as f 
ON f.nome_paciente = b.nom_pessoa and f.nascimento = b.dta_nasc_pessoa;

select distinct f.nome_paciente, f.nascimento, f.cns_paciente
into join_fila_bpc_nome_nascimento_cns from dados_bpc as b inner join dados_fila as f 
ON f.nome_paciente = b.nom_pessoa and f.nascimento = b.dta_nasc_pessoa;