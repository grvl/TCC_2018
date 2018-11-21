# Edição do mapa IBGE

0 . Join as tabelas dos os dados espaciais (formato de cada área de ponderação) com a com os dados descritivos (os dados sobre pessoas com dificuldades) em uma tabela nova.
1. Cria um GeoJSON com as informações da tabela nova.
2. (2.1). As áreas de ponderação são Multipolygons: polígonos com buracos. Editar o GeoJSON para transformar as áreas de ponderação em Polygons já remove os buracos.

    (2.2). Para remover os buracos maiores e lacunas, é utilizado a biblioteca Shapely. É neste script que criamos as áreas de ponderação 'customizadas'.
3. Pegar a tabela de dados Free Wheels e procurar quais regiões de ponderação pertencem a cada distrito. Com isso, conseguimos encontrar o nome do distrito de cada área de ponderação para exibição de nome, além de adicionar um ID a cada área. É neste script que também transferimos os dados SMPED para o GeoJSON, além de calcular cores e rankings.
4.  (4.1). (Opcional)  Criar tabela para upload dos nomes dos distrittos de cada área de ponderação.

    (4.2). (Opcional) Fazer upload do nome do distrito para cada área de ponderação.
5. (Opcional) Atualizar as fronteiras das zonas de São Paulo do IBGE para seguirem o contorno das áreas de ponderação.
