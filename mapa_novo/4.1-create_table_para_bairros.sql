drop table IF EXISTS tratado.bairros_e_zonas_geo;

--geom, geocodigo, nome, zona, id -- Upload da zona e bairo de cada geom
CREATE TABLE tratado.bairros_e_zonas_geo (
  geom		geometry,
  geocodigo bigint unique,
  name text,
  zone text,
  id SERIAL,
  PRIMARY KEY (id)

);
