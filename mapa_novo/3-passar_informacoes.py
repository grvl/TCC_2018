import json
from shapely.geometry import MultiPolygon, asShape
from shapely.geometry.polygon import Polygon
import branca.colormap as cm
import os
import pandas as pd

#
# Pega qual área do Freewheels insercta mais com a área do IBGE e copia as informacoes, especificamente o nome e bairro. Também pega os dados da SMPED por ID.
#

def get_asShape(lista):
    return {'polygon': asShape(lista['geometry']), 'properties':lista['properties']}

polygon_ibge_file = "shape3.json"
polygon_freewheels_file = "distritos-ranked.json"
regioes_recebe_beneficio_csv = os.path.join('SMPED', "regioes_recebe_beneficio.csv")

f_ibge = open(polygon_ibge_file, 'r')
ibge_json = json.load(f_ibge)
ibge_map = list(map(get_asShape, ibge_json['features']))

f_fw = open(polygon_freewheels_file, 'r')
fw_json = json.load(f_fw)
fw_map = list(map(get_asShape, fw_json['features']))

regioes_recebe_beneficio = pd.read_csv(regioes_recebe_beneficio_csv).set_index('ID')['valor']

total_dificuldade_enxergar = 0
total_dificuldade_ouvir = 0
total_dificuldade_caminhar = 0
total_deficiencia_intelectual = 0
total_dificuldade_geral = 0

for i in range(0, len(ibge_map)):
    if 'dados_ibge' in ibge_json['features'][i]['properties']:
        total_dificuldade_enxergar += ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_enxergar']
        total_dificuldade_ouvir += ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_ouvir']
        total_dificuldade_caminhar += ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_caminhar']
        total_deficiencia_intelectual += ibge_json['features'][i]['properties']['dados_ibge']['deficiencia_intelectual']
        total_dificuldade_geral += ibge_json['features'][i]['properties']['dados_ibge']['total_dificuldade']
    else:
        ibge_json['features'][i]['properties']['dados_ibge'] =  {"dificuldade_enxergar": 0, "dificuldade_ouvir": 0, "dificuldade_caminhar": 0, "deficiencia_intelectual": 0, "total_dificuldade": 0, "total_contavel": 1, "total_pessoas": 0}

def color_function(linear, feature):
    if feature > 0:
        return linear(feature)
    else:
        return '#636466'

id = 1
scores = {
    'dificuldade_geral' : [],
    'enxergar_geral' : [],
    'ouvir_geral' : [],
    'caminhar_geral' : [],
    'intelectual_geral' : [],
    'dificuldade' : [],
    'enxergar' : [],
    'ouvir' : [],
    'caminhar' : [],
    'intelectual' : [],
    'smped' : []
}

for i in range(0, len(ibge_map)):
    size = 0
    match = {}
    if not (ibge_map[i]['polygon'].is_valid):
        ibge_map[i]['polygon']=ibge_map[i]['polygon'].buffer(0)

    for item in fw_map:
        aux = item['polygon'].intersection(ibge_map[i]['polygon'])
        if not aux.is_empty:
            if aux.area > size:
                size = aux.area
                match = item
    # ibge_json['features'][i]['properties']['dific'] = {"topography": {"color": "#6AB36A", "ranking": 28, "value": 8.4076}, "bus": {"color": "#D7CA62", "ranking": 70, "value": 5.8826}, "venues": {"color": "#71B569", "ranking": 21, "value": 8.2336}, "subway": {"color": "#E68A4E", "ranking": 31, "value": 2.5676}, "parking": {"color": "#A4C065", "ranking": 38, "value": 7.0511}, "total": {"color": "#9BBE66", "ranking": 22, "value": 7.2694}}
    ibge_json['features'][i]['properties']['id'] = id
    id += 1
    ibge_json['features'][i]['properties']['zone'] = match['properties']['zone']
    ibge_json['features'][i]['properties']['name'] = match['properties']['name'] + " (ID "+str(ibge_json['features'][i]['properties']['id'])+")"
    ibge_json['features'][i]['properties']['scores'] = {
        'dificuldade_geral' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['total_dificuldade']/ibge_json['features'][i]['properties']['dados_ibge']['total_contavel'])/100},
        'enxergar_geral' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_enxergar']/ibge_json['features'][i]['properties']['dados_ibge']['total_contavel'])/100},
        'ouvir_geral' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_ouvir']/ibge_json['features'][i]['properties']['dados_ibge']['total_contavel'])/100},
        'caminhar_geral' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_caminhar']/ibge_json['features'][i]['properties']['dados_ibge']['total_contavel'])/100},
        'intelectual_geral' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['deficiencia_intelectual']/ibge_json['features'][i]['properties']['dados_ibge']['total_contavel'])/100},
        'dificuldade' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['total_dificuldade']/total_dificuldade_geral)/100},
        'enxergar' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_enxergar']/total_dificuldade_enxergar)/100},
        'ouvir' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_ouvir']/total_dificuldade_ouvir)/100},
        'caminhar' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['dificuldade_caminhar']/total_dificuldade_caminhar)/100},
        'intelectual' : {'color' : '', 'value' : int(10000 * ibge_json['features'][i]['properties']['dados_ibge']['deficiencia_intelectual']/total_deficiencia_intelectual)/100},
        'smped' : {'color' : '', 'value' : int(regioes_recebe_beneficio[ibge_json['features'][i]['properties']['id']])}

    }

    for key in ibge_json['features'][i]['properties']['scores']:
        scores[key].append(ibge_json['features'][i]['properties']['scores'][key]['value'])

for key in scores:
    scores[key] = sorted(scores[key], reverse=True)
    print( "max em " + key + ": " + str(scores[key][0]))

for i in range(0, len(ibge_map)):
    for key in ibge_json['features'][i]['properties']['scores']:
        ibge_json['features'][i]['properties']['scores'][key]['ranking'] = scores[key].index(ibge_json['features'][i]['properties']['scores'][key]['value']) + 1
        linear = cm.LinearColormap(
            ['green', 'yellow', 'red'],
            vmin=0, vmax=scores[key][0]
        )
        ibge_json['features'][i]['properties']['scores'][key]['color'] = color_function(linear, ibge_json['features'][i]['properties']['scores'][key]['value'])

out = open("shape4.json",'w', newline="")
out.write(json.dumps(ibge_json))
