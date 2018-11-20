export PGPASSWORD='123456'

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/python/data/bus_lines_geo.json" -nln data.bus_line

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/python/data/estabelecimentos/sp_venues.json" -nln data.venues

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/python/data/estabelecimentos/prefeitura/selo-prefeitura-latlong.json" -nln data.prefeitura_venues

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/python/data/vagas/ZonaAzuVagas_DF_ID_latlong.json" -nln data.zona_azul

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/r/cptm-sp/cptm.shp" -nln data.cptm -skip-failures

ogr2ogr -f "PostgreSQL" PG:"dbname=ibge user=lima" "../free_wheels/scripts/r/metro-sp/metro.shp" -nln data.metro2 -skip-failures
