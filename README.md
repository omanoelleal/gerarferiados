# Procedure Gerar Feriados Brasil / RJ
Script SQL Server para geração de Tabela com os feriados do Brasil.

Primeiro passo é necessário criar a procedure com o código abaixo. 

<a href="https://github.com/manoelleal17/gerarferiados/blob/main/SQL_GERAR_TBL_FERIADOS.sql">Acessar o Código</a>

A procedure está configurada para gerar os feriados de 1990 até 2099, caso deseje alterar o período é só alterar as variáveis:

        @Dt_Inicial datetime = '1990-01-01'
        
        @Dt_Final datetime = '2099-01-01'

Depois de executar a procedure será criada a tabela: TBL_FERIADOS. No formato:

<p align="center"><img src="https://github.com/manoelleal17/gerarferiados/blob/main/Exemplo.png" ></p>


import pymongo
import csv
from unicodedata import normalize

#Função para remover acentos
def remover_acentos(txt):
  return normalize('NFKD', txt).encode('ASCII', 'ignore').decode('ASCII')

#Conecta no mongoDB
myclient = pymongo.MongoClient("mongodb://localhost:27017")
mydb = myclient["dbmanoel"]
mycol = mydb["case_ingresso"]

#Carrega o csv com os dados do COVID
dadosCovid = open('C:/Users/Manoel/Desktop/CASE_INGRESSO/casos_covid.csv')
reader = csv.reader(dadosCovid, delimiter=',')
header = False

#Realiza o tratamento nos dados
for linha in reader:
    if header == False:
        header = True
        continue
    else:
        if linha[3] != 'state' and linha[2] != 'Importados/Indefinidos':
            mydocument = {
                "date": {
                    "day": linha[0][8:10],
                    "month": linha[0][5:7],
                    "year": linha[0][:4],
                    "date_formated": linha[0]},
                "Location": {
                    "state":linha[1],
                    "city":linha[2],
                    "city_no_accents":remover_acentos(linha[2]),
                    "id_IBGE":linha[10]},
                "covid_data":{
                    "confirmed":linha[4],
                    "deaths":linha[5]},
                "is_last":linha[7],
                "estimated_population": linha[9]}
            mycol.insert_one(mydocument)
