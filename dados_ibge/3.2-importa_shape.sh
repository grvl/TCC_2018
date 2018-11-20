#!/bin/bash

#precisa create extension postgis e postgis_topology na DB -- precisa ser superuser

CAMINHO_SCRIPT="./"
SCRIPT='importacao.sql'
PESQUISA='CENSO'
ANO_REF='2010'

for contador_ponderacao in `ls dados/35_SP_Sao_Paulo/35SEE250GC_SIR_area_de_ponderacao.shp`; do

	TABELA='shp_35see250gc_sir_area_de_ponderacao'

	shp2pgsql -e -t '2D' -s 4674 -a $contador_ponderacao ${TABELA} >> ${CAMINHO_SCRIPT}/${SCRIPT} 2> erros.txt

done;

echo -e "\e[5;32;47m ***********************************************\e[0m"
echo -e "\e[5;34;47m fazendo insert no banco de dados !\e[0m"
echo -e "\e[5;32;47m ***********************************************\e[0m"

export PGPASSWORD='123456'

psql -U lima -h 127.0.0.1 -d ibge -a -f  ${CAMINHO_SCRIPT}/${SCRIPT} 2> erros.txt
