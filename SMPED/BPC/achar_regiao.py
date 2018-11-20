from geopy.geocoders import Nominatim, GoogleV3
import psycopg2
import json
import sys
from shapely.geometry import MultiPolygon, asShape
from shapely.geometry.polygon import Polygon
import requests
import time

dbname = 'SMPED'
user = 'lima'
pswd = '123456'
pref_regional_sp = "../../free_wheels/scripts/python/data/distritos-latlong.json"


try:
    conn = psycopg2.connect("dbname='"+dbname+"' user='"+user+"' host='localhost' password='"+pswd+"'")
except:
    print ("Nao foi possivel conectar com o banco")
    exit()

try:
    cur = conn.cursor()
    cur.execute("""
    select distinct lat, longi from dados_bpc where regiao_ibge is null order by lat ASC limit 49376
    """)

    rows = cur.fetchall()
except:
    e = sys.exc_info()
    print(e)
    print ("Select falhou")
    exit()

conn.close()

def get_asShape(lista):
    return {'polygon': asShape(lista['geometry']), 'properties':lista['properties']}

f = open(pref_regional_sp, 'r')
json = json.load(f)
map = list(map(get_asShape, json['features']))

for row in rows:
    if row[0] is not None and row[1] is not None:
        point = asShape({'type': 'Point','coordinates': [float(row[1]),float(row[0])]})  # GeoJsons inverts the pair order.
        aux = 0
        for regiao in map:
            if regiao['polygon'].contains(point):
                print ("update dados_bpc SET regiao_ibge = '" + str(regiao['properties']['ds_codigo']) + "' where lat = '" +row[0]+"' and longi = '"+row[1]+"'")
                aux = 1
                break;
        if aux == 0:
            print ("update dados_bpc SET regiao_ibge = 'Outros' where lat = '" +row[0]+"' and longi = '"+row[1]+"'")
