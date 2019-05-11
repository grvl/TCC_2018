import psycopg2
import json


#
# Pega as iinformacões do IBGE do banco e cria um JSON com as divisões de distrito
#

dbname = 'ibge'
user = 'lima'
pswd = '123456'
output_json_file = "shape1.json"
try:
    conn = psycopg2.connect("dbname='"+dbname+"' user='"+user+"' host='localhost' password='"+pswd+"'")
except:
    print ("Nao foi possivel conectar com o banco")
    exit()

print("Conectado com o banco")

try:
    cur = conn.cursor()
    cur.execute("""
    select geocodigo, distrito, area_apuracao, dificuldade_enxergar, dificuldade_ouvir, dificuldade_caminhar, deficiencia_intelectual, total_dificuldade, total_contavel, total, ST_AsGeoJSON(geom) from tratado.dados_ibge
    """)
    rows = cur.fetchall()
except:
    print ("Select falhou")
    exit()

conn.close()

counter = 0
json_output = json.loads("""
{"type": "FeatureCollection", "features": []}
""")
features = []
for row in rows:
    distrito = int(row[1])
    dic = {"geometry": json.loads(row[-1]),
            "type": "Feature",
            "properties":{"geocodigo":row[0],
                            "distrito":distrito,
                            "area_apuracao":int(row[2]),
                            "dados_ibge":{
                                "dificuldade_enxergar":int(row[3]),
                                "dificuldade_ouvir":int(row[4]),
                                "dificuldade_caminhar":int(row[5]),
                                "deficiencia_intelectual":int(row[6]),
                                "total_dificuldade": int(row[7]),
                                "total_contavel" : int(row[8]), #soma de todas as pessoas que responderam de um modo ou outro as perguntas de dificuldades
                                "total_pessoas":int(row[9])
                            }
                            }} #, "fill":cor}}
    counter += 1
    features.append(dic)
json_output["features"]=features
# json_output.append({ "features":[features]})

print("Foram lidas " +str(counter)+ " linhas")
out = open(output_json_file,'w', newline="")
out.write(json.dumps(json_output))
