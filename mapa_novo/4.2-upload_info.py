import psycopg2
import json
import geojson
import sys
from shapely.geometry import asShape, shape

#
# Upload das informacoes do freewheels com o mapa iBGE
#

def get_asShape(lista):
    return {'geom': asShape(lista['geometry']).wkt, 'geocodigo':lista['properties']['geocodigo'], 'name':lista['properties']['name'], 'zone':lista['properties']['zone'], 'id':lista['properties']['id']}

dbname = 'ibge'
user = 'lima'
pswd = '123456'
output_json_file = "shape.json"
try:
    conn = psycopg2.connect("dbname='"+dbname+"' user='"+user+"' host='localhost' password='"+pswd+"'")
except:
    print ("Nao foi possivel conectar com o banco")
    exit()

print("Conectado com o banco")

polygon_ibge_file = "shape4.json"

f_ibge = open(polygon_ibge_file, 'r')
ibge_json = json.load(f_ibge)
ibge_dados = list(map(get_asShape, ibge_json['features']))

try:
    cur = conn.cursor()
    for a in ibge_dados:
        # print(a)
        print("INSERT INTO tratado.bairros_e_zonas_geo(geom, geocodigo, name, zone, id) VALUES " + "(ST_GeomFromText('" +a['geom']+ "'), "+str(a['geocodigo'])+", '"+a['name']+"', '"+a['zone']+"'), "+str(a['id'])+";")
        cur.execute("INSERT INTO tratado.bairros_e_zonas_geo(geom, geocodigo, name, zone, id) VALUES " + "(ST_GeomFromText('" +a['geom']+ "'), "+str(a['geocodigo'])+", '"+a['name']+"', '"+a['zone']+"', "+str(a['id'])+");")
except:
    e = sys.exc_info()
    print( "<p>Error: %s</p>" % e )
    print ("Insert falhou")
    exit()

conn.commit()
conn.close()

# counter = 0
# json_output = json.loads("""
# {"type": "FeatureCollection", "features": []}
# """)
# features = []
# for row in rows:
#     distrito = int(row[1])
#     # cor = "#ff0000"
#     # if distrito == 50:
#     #     cor = "#00ff00"
#     # elif distrito == 51:
#     #     cor = "#0000ff"
#     # elif distrito == 52:
#     #     cor = "#ffffff"
#     dic = {"geometry": json.loads(row[-1]), "type": "Feature", "properties":{"geocodigo":row[0], "distrito":distrito,"area_apuracao":int(row[2]), "fill":cor}}
#     counter += 1
#     features.append(dic)
# json_output["features"]=features
# # json_output.append({ "features":[features]})
#
# print("Foram lidas " +str(counter)+ " linhas")
# out = open(output_json_file,'w', newline="")
# out.write(json.dumps(json_output))
