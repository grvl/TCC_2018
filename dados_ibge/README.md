# Tutorial: Censo 2010 IBGE

Neste tutorial, exploramos alguns dados do Censo 2010, disponibilizados pelo IBGE.

## Conceitos

Nos dados do IBGE, todas as colunas são totalizadas dentro de uma unidade de espaço chamada Setor Censitário. Um Setor possui de 250 a 300 famílias.

Existem pesquisas totais (Censo) e Amostrais (PNAD). Nas totais, são varridos 100% dos domicílios dentro do Setor e nas amostrais, 33% destes domicílios por ano.
Os detalhes estão nos documentos sobre a metodologia disponibilizados pelo IBGE.
O Censo 2010 foi a ultima varredura total feita pelo IBGE - o governo federal cancelou a contagem 2015 - o resto é amostral.

Para presenvar o anonimato, todo questionário aplicado à população é "totalizado" por setor. Por exemplo: no setor 003300551800 existem 10 médicos, 500 pessoas, renda média de 2.500,00 reais, 40 desempregados, etc. Cada atributo é uma coluna.
Os dados são disponibilizados em formato SAS Texto.

Para fazer uma extração de informação dos dados, são necessários:

  - Os dados espaciais (setores)
  - Os dados estatísticos puros.

Em resumo, os dados espaciais são uma tabela com blob (desenho) e uma chave primária (código do setor).
A "tabela" do censo não-geográfica se associa com os dados geográficos pela chave primária.

Para análise, é necessário baixar todo o arquivo estatistico (nao espacial),
todo o acervo espacial de setores (Shapefile), converter tudo que puder para o R, salvar em um banco de dados (aqui, utilizamos o postgres) e exportar a filtragem de interesse para o formato desejado.

Isso é feito através de queries no banco de dados (Joins) e filtragem das colunas e predicados desejados.

## Preparação

### Download dos dados

Os dados estão disponíveis para download nos servidores de FTP do IBGE.

Microdados:
`ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/`

Setores (áreas de ponderação):
`ftp://geoftp.ibge.gov.br/recortes_para_fins_estatisticos/malha_de_areas_de_ponderacao/censo_demografico_2010/`

Para este tutorial:

  - Faça download do arquivo `SP2-RM.zip`, referente à região metropolitana de São Paulo.
  - Descompacte-o e salve na pasta `dados/`.

**Obs:** as "colunas" dos dados são codificadas, ex: `V0001`, `V0002`. O arquivo `dados/Layout_microdados_Amostra.xls` contém as informações sobre o que representa cada uma delas.

### Ferramentas

  - Instale e configure o Postgres.
    - Crie um novo banco de dados para os dados do IBGE (recomendado).
  - Instale e configure o R.


## Analisando os dados

Os arquivos correspondentes a cada etapa estão numerados de acordo.

  - **Passo 1**: Carregamento dos dados do IBGE no R e exportação para um arquivo `.Rdata`.
  - **Passo 2**: Importação dos dados no Postgres.
  - **Paso 3**: Importacão dos dados de SHP pro Postgres usando POSTGIS.
  - **Passo 4**: Filtra e trata os dados.
  - **Passo 5**: Combina os dados espaciais com os dados amostrais.
