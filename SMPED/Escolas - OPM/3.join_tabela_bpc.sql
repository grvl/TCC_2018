drop table if exists join_escolas_bpc_nome_mae_nascimento;
drop table if exists join_escolas_bpc_mae;
drop table if exists join_escolas_bpc_mae_pessoa;

select distinct f.aluno, f.nasc, f.nome_mae
into join_escolas_bpc_nome_mae_nascimento from dados_bpc as b inner join dados_escolas as f 
ON f.aluno = b.nom_pessoa and f.nasc = b.dta_nasc_pessoa 
and b.nom_completo_mae_pessoa = f.nome_mae;


select distinct f.nome_mae, f.sexo, f.idade
into join_escolas_bpc_mae from dados_bpc as b inner join (select * from dados_escolas as e where e.aluno not in  (select aluno from join_escolas_bpc_nome_mae_nascimento)) as f 
ON b.nom_completo_mae_pessoa = f.nome_mae;

select distinct f.nome_mae, f.sexo, f.idade
into join_escolas_bpc_mae_pessoa from dados_bpc as b inner join (select * from dados_escolas as e where e.aluno not in  (select aluno from join_escolas_bpc_nome_mae_nascimento)) as f 
ON b.nom_pessoa = f.nome_mae;