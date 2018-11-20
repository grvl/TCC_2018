import json
import geojson
from shapely.ops import cascaded_union
from shapely.geometry import MultiPolygon, asShape
from shapely.geometry.polygon import Polygon

#
# Utiliza um buffer para "arredondar" as regiões e remover falhas nas pontas do mapa. Também utiliza o mapa do freewheels para "completar" as falhas maiores no mapa.
#
# https://gist.github.com/drmalex07/5a54fc4f1db06a66679e#file-convert-wkt-to-geojson-py

def get_asShape(lista):
    return asShape(lista['geometry'])

polygon_ibge_file = "shape2.json"
polygon_freewheels_file = "distritos-ranked.json"

f_ibge = open(polygon_ibge_file, 'r')
ibge_json = json.load(f_ibge)
ibge_map = list(map(get_asShape, ibge_json['features']))


f_fw = open(polygon_freewheels_file, 'r')
fw_json = json.load(f_fw)
fw_map = list(map(get_asShape, fw_json['features']))

for i in range(0, len(ibge_map)):
    if not (ibge_map[i].is_valid):
        ibge_map[i]=ibge_map[i].buffer(0)
polygon_ibge = cascaded_union(ibge_map)
# print(polygon_ibge.area)
polygon_fw = cascaded_union(fw_map)
polygons = polygon_fw.difference(polygon_ibge)
# print(polygons.type)

aux = []
geocodigo = 3550308005311
for p in polygons:
    if p.area > 0.0001:
        # print(p.area)
        eps = 0.00025
        aux += [geojson.Feature(geometry = p.buffer(eps).buffer(-1 * eps), properties = {"geocodigo": geocodigo})]
        geocodigo += 1

ibge_json['features'] += aux


# print(aux)
out = open("shape3.json",'w', newline="")
out.write(json.dumps(ibge_json))
