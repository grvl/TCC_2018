import json
import geojson
from shapely.ops import cascaded_union
from shapely.geometry import MultiPolygon, asShape
from shapely.geometry.polygon import Polygon

#
# Cria um mapa das zonas de Sao Paulo usando as divisões de distrito do IBGE em vez de do Freewheels
#

def get_asShape(lista):
    return {'polygon': asShape(lista['geometry']), 'properties':lista['properties']}

polygon_ibge_file = "shape4.json"
sp_zonas = "sp_zonas.json"

f_ibge = open(polygon_ibge_file, 'r')
ibge_json = json.load(f_ibge)
ibge_map = list(map(get_asShape, ibge_json['features']))

zonas_json = json.load(open(sp_zonas, 'r'))

norte = []
sul = []
leste = []
oeste = []
centro = []
for i in range(0, len(ibge_map)):
    if not (ibge_map[i]['polygon'].is_valid):
        ibge_map[i]['polygon']=ibge_map[i]['polygon'].buffer(0)
    if ibge_map[i]['properties']['zone'] == 'Norte':
        norte += [ibge_map[i]['polygon']]
    elif ibge_map[i]['properties']['zone'] == 'Sul':
        sul += [ibge_map[i]['polygon']]
    elif ibge_map[i]['properties']['zone'] == 'Leste':
        leste += [ibge_map[i]['polygon']]
    elif ibge_map[i]['properties']['zone'] == 'Oeste':
        oeste += [ibge_map[i]['polygon']]
    elif ibge_map[i]['properties']['zone'] == 'Centro':
        centro += [ibge_map[i]['polygon']]

for i in range(0, len(zonas_json['features'])):
    eps = 0.00025
    polygon = Polygon()
    if zonas_json['features'][i]['properties']['NOME'] == 'Norte':
        print("Norte")
        geometry = norte

    if zonas_json['features'][i]['properties']['NOME'] == 'Sul':
        print("Sul")
        geometry = sul

    if zonas_json['features'][i]['properties']['NOME'] == 'Leste':
        print("Leste")
        geometry = leste

    if zonas_json['features'][i]['properties']['NOME'] == 'Oeste':
        print("Oeste")
        geometry = oeste

    if zonas_json['features'][i]['properties']['NOME'] == 'Centro':
        print("Centro")
        geometry = centro

    zonas_json['features'][i] = geojson.Feature(geometry = cascaded_union(geometry).buffer(eps).buffer(-1 * eps), properties = zonas_json['features'][i]['properties'])

out = open("shape5.json",'w', newline="")
out.write(json.dumps(zonas_json))
