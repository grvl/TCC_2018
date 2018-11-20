import json
from shapely.geometry import MultiPolygon, asShape
from shapely.geometry.polygon import Polygon

#
#Arruma as falhas na divisão do IBGE
#

def get_asShape(lista):
    return {'polygon': asShape(lista['geometry'])}

polygon_ibge_file = "shape1.json"
polygon_freewheels_file = "distritos-ranked.json"

f_ibge = open(polygon_ibge_file, 'r')
ibge_json = json.load(f_ibge)
ibge_map = map(get_asShape, ibge_json['features'])
for item in ibge_json['features']:
    item['geometry']['type']='Polygon'
    item['geometry']['coordinates']= [item['geometry']['coordinates'][0][0]]

out = open("shape2.json",'w', newline="")
out.write(json.dumps(ibge_json))

# f_freewheels = open(polygon_freewheels_file, 'r')
# freewheels_json = json.load(f_freewheels)
# freewheels_map = map(get_asShape, freewheels_json['features'])
# for item in freewheels:
#     print(item['polygon'].geom_type)

# for polygon in ibge_map:
#     ibge = ibge.union(polygon['polygon'])
# http://toblerity.org/shapely/manual.html#polygons
