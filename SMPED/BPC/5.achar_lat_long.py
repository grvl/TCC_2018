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
pref_regional_sp = "SIRGAS_SHP_prefeitura_regional_polygon.json"


try:
    conn = psycopg2.connect("dbname='"+dbname+"' user='"+user+"' host='localhost' password='"+pswd+"'")
except:
    print ("Nao foi possivel conectar com o banco")
    exit()

# print("Conectado com o banco")

try:
    cur = conn.cursor()
    cur.execute("""
    select NOM_TIP_LOGRADOURO_FAM, NOM_TITULO_LOGRADOURO_FAM, NOM_LOGRADOURO_FAM, NUM_LOGRADOURO_FAM, nom_localidade_fam from dados_bpc where lat is Null order by nom_localidade_fam ASC
    """)

    # cur.execute("""
    # select distinct(nom_localidade_fam) from dados_bpc where where regiao like '%encontrado' order by nom_localidade_fam limit 1
    # """)
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

regioes = {}
not_found = 0
cidades = {}

for i in range(0, len(map)):
    regioes[map[i]['properties']['sp_nome']] = 0

geolocator = GoogleV3(api_key='your_key', timeout = 5)
# geolocator = Nominatim(user_agent="specify_your_app_name_here", timeout = 3)
for row in rows:
    # time.sleep(0.1)
    endereco = ''
    for string in row:
        if string is not None:
            endereco = endereco + str(string) + " "
    r = ["", "", "", "", ""]
    for i in range(0,5):
        if row[i] is not None:
            r[i] = "'" + str(row[i]) + "'"
        else:
            r[i] = None
    # print(endereco)
    string = "update dados_bpc SET lat = '"
    try:
        location = geolocator.geocode(query = (endereco +  "São Paulo"))
        if location is not None and location.latitude != -23.5505199 and location.longitude != -46.63330939999999:
            print("--" + location.address)
            # print((location.latitude, location.longitude))
            string = string + str(location.latitude) + "', longi = '" + str(location.longitude) + "' where "
                string = string + "NOM_TIP_LOGRADOURO_FAM = "+r[0]+""
            if r[1] is not None:
                string = string + " and NOM_TITULO_LOGRADOURO_FAM = "+r[1]+""
            if r[2] is not None:
                string = string + " and NOM_LOGRADOURO_FAM = "+r[2]+""
            if r[3] is not None:
                string = string + " and NUM_LOGRADOURO_FAM = "+r[3]+""
            if r[4] is not None:
                string = string + " and nom_localidade_fam = "+r[4]+""
            string = string + ";"
            # string = string + "and regiao = 'n.e';"
            print(string)


    except:
        e = sys.exc_info()
        print(e)
