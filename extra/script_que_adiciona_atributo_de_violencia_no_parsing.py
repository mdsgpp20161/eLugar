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


with open('old_seeds.rb') as seedFile:
	newOutput = ""
	for lineInSeed in seedFile:
		matches=re.findall(r'\"(.+?)\"',lineInSeed)
		if matches:				 
			newViolence = 'violence: ' + str(getViolenceIndex(matches[0], getStateAcronym(matches[1]))) + ')'
			newOutput += lineInSeed.replace('violence: 9.6)', newViolence)
	text_file = open("seeds.rb", "w")
	text_file.write(newOutput)
	#text_file.write(sql_statement.encode('utf-8'))
	text_file.close()