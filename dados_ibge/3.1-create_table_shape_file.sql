CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

-- Vai ser criado no public por que o postgis é instalado no public
CREATE TABLE shp_35see250gc_sir_area_de_ponderacao (
	pesquisa	varchar(10) default 'CENSO',
	ano_ref		smallint default '2010',
	hora_impor	varchar(10),
	id		integer,
	count		integer,
	area_pond	varchar(20),
	geom		geometry
);
