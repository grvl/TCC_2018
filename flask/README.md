# Setup do website

## Preparação

### Ferramentas

  - Instale e configure o Postgres.
  - Crie um novo banco de dados para os dados para pesquisa (recomendado).

## Flask
0. Instalar os módulos geopy, psycopg2-binary, geojson, numpy, geog, folium, shapely
1. Instalar PostGIS no banco de dados PostgreSQL: https://postgis.net/docs/postgis_installation.html#install_short_version
  * Não há necessidade de sfcgal support, tiger geocoder ou pcre
2. Rodar o arquivo db/1.upload_data.sh
  * Não esquecer de e editar o arquivo com seu usuário e DB
  * O driver https://www.gdal.org/drv_geojson.html precisa estar instalado
  * Se quiser que os bancos sejam criados em uma outra Schema que não a public, apenas edite o nome nos comandos para incluir a schema desejada (Ex: bus_line >> schema_desejada.bus_line)
3. `python3 app.py` para rodar o servidor em `127.0.0.1:5000`
  * A porta e host são editáveis no começo do arquivo


## Jekyll

Mais informações podem ser vistas no arquivo readme dentro da pasta Free Wheels

# Rodando em localhost

1. Instale o Ruby.
2. `gem install bundle`
3. `bundle install --vendor`
4. `bundle exec jekyll server`
   * Use o parâmetro `-w` ou `--watch` para que o servidor detecte mudanças e atualize automaticamente.
5. Acesse a página na porta 4000.
