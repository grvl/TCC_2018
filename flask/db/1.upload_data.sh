ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/python/data/bus_lines_geo.json" -nln bus_line

ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/python/data/estabelecimentos/sp_venues.json" -nln venues

ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/python/data/estabelecimentos/prefeitura/selo-prefeitura-latlong.json" -nln prefeitura_venues

ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/python/data/vagas/ZonaAzuVagas_DF_ID_latlong.json" -nln zona_azul

ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/r/cptm-sp/cptm.shp" -nln cptm -skip-failures

ogr2ogr -f "PostgreSQL" PG:"dbname=pesquisa user=lima" "../free_wheels/scripts/r/metro-sp/metro.shp" -nln metro2 -skip-failures
