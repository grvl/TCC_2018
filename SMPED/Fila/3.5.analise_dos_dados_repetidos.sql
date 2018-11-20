drop table if exists join_fila_bpc_nomes_repetidos;

select *, 'join_fila_bpc_nome_mae_nascimento_cns' as tabela into join_fila_bpc_nomes_repetidos 
from join_fila_bpc_nome_mae_nascimento_cns 
where nome_paciente in 
(select nome_paciente from join_fila_bpc_nome_mae_nascimento_cns t 
group by nome_paciente having count(nome_paciente) > 1);

insert into join_fila_bpc_nomes_repetidos 
select nome_paciente, nascimento, '' as mae_paciente, cns_paciente, 'join_fila_bpc_nome_nascimento_cns' as tabela 
from join_fila_bpc_nome_nascimento_cns 
where nome_paciente in 
(select nome_paciente from join_fila_bpc_nome_nascimento_cns t 
group by nome_paciente having count(nome_paciente) > 1);

select * from join_fila_bpc_nomes_repetidos;