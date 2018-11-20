
install.packages(c("SAScii","rgeos","sp","rgdal","RPostgreSQL","SAScii"))


library(rgeos)
library(sp)
library(rgdal)
library(RPostgreSQL)
library(SAScii)


gc()

load('./censo_2010_amostra_domicilios.Rdata')
load('./censo_2010_amostra_pessoas.Rdata')


# loads the PostgreSQL driver
driver_carregado <- dbDriver("PostgreSQL")

user <- { "lima" }
pass <- { "123456" }
dbname <- { "ibge" }

conexao <- dbConnect(driver_carregado, dbname = dbname, host = "127.0.0.1", port = 5432, user = user, password = pass)
rm(pass)


dbWriteTable(conexao, c("importado","censo_2010_domicilios"), value = dados_lidos_dom, append = TRUE, row.names = FALSE)
dbWriteTable(conexao, c("importado","censo_2010_pessoas"), value = dados_lidos_pes, append = TRUE, row.names = FALSE)

#=======================================================================
