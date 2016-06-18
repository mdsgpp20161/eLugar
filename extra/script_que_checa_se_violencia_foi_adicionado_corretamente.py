# -*- coding: utf-8 -*-

import csv
import re

def getViolenceIndex(cityName, stateName):
	with open('TaxaAF.csv', 'rb') as violenceIndexFile:
		reader = csv.reader(violenceIndexFile)
		violenceIndexList = list(reader)

	numberOfLines = sum(1 for row in violenceIndexList)

	for lineIndex in range(3,numberOfLines-2):
		if(cityName == violenceIndexList[lineIndex][0] and stateName == violenceIndexList[lineIndex][1]):
			if(violenceIndexList[lineIndex][9] != ""):
				return violenceIndexList[lineIndex][9]
			else:
				return "0.0"
		

def getStateAcronym(stateName):
	if stateName == "Acre":
		return "AC"
	elif stateName == "Alagoas":
		return "AL"
	elif stateName == "Amapá":
		return "AP"
	elif stateName == "Amazonas":
		return "AM"
	elif stateName == "Bahia":
		return "BA"	
	elif stateName == "Ceará":
		return "CE"
	elif stateName == "Distrito Federal":
		return "DF"
	elif stateName == "Espírito Santo":
		return "ES"
	elif stateName == "Goiás":
		return "GO"
	elif stateName == "Maranhão":
		return "MA"
	elif stateName == "Mato Grosso":
		return "MT"
	elif stateName == "Mato Grosso do Sul":
		return "MS"
	elif stateName == "Minas Gerais":
		return "MG"
	elif stateName == "Pará":
		return "PA"
	elif stateName == "Paraíba":
		return "PB"
	elif stateName == "Paraná":
		return "PR"
	elif stateName == "Pernambuco":
		return "PE"
	elif stateName == "Piauí":
		return "PI"
	elif stateName == "Rio de Janeiro":
		return "RJ"
	elif stateName == "Rio Grande do Norte":
		return "RN"
	elif stateName == "Rio Grande do Sul":
		return "RS"
	elif stateName == "Rondônia":
		return "RO"
	elif stateName == "Roraima":
		return "RR"
	elif stateName == "Santa Catarina":
		return "SC"
	elif stateName == "São Paulo":
		return "SP"
	elif stateName == "Sergipe":
		return "SE"
	elif stateName == "Tocantins":
		return "TO"
	else:
		return "NONE"


with open('seeds.rb') as seedFile:
	for lineInSeed in seedFile:
		cityName=re.findall(r'\"(.+?)\"',lineInSeed)
		violenceIndex=re.findall(r'violence: (.+?)\)',lineInSeed)
		if cityName:				 
			if str(getViolenceIndex(cityName[0], getStateAcronym(cityName[1]))) != violenceIndex[0]:
				print "Erro na " + cityName[0] + " - " + cityName[1]