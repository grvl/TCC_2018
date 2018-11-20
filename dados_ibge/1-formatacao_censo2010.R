install.packages(c("SAScii","rgeos","sp","rgdal","RPostgreSQL","SAScii"))


library(rgeos)
library(sp)
library(rgdal)
library(RPostgreSQL)
library(SAScii)


gc()

dicionario_domicilios <- "./1-separacao_colunas_domicilios.sas"
dados_domicilios      <- "./dados/SP2-RM/Amostra_Domicilios_35_RMSP.txt"

dicionario_pessoas <- "./1-separacao_colunas_pessoas.sas"
dados_pessoas      <- "./dados/SP2-RM/Amostra_Domicilios_35_RMSP.txt"

ls()
dados_lidos_dom <- read.SAScii(dados_domicilios,dicionario_domicilios,beginline=1,buffersize=1000)
dados_lidos_pes <- read.SAScii(dados_pessoas,dicionario_pessoas,beginline=1,buffersize=1000)
ls()
save( dados_lidos_dom , file ="censo_2010_amostra_domicilios.Rdata" )
save( dados_lidos_pes , file ="censo_2010_amostra_pessoas.Rdata" )
