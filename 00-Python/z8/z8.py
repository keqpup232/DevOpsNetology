import json
from pprint import pprint
from string import punctuation
from collections import Counter

#print ('Написать программу, которая будет выводить топ 10 самых часто встречающихся в новостях слов длиннее 6 символов для каждого файла.')

def get_result_file_json(file,file_result):
	f = open(file_result, 'w')
	f.close()
	with open (file, encoding="utf-8") as f:
		data = json.load(f)
		items=data['rss']['channel']['items']
		for item in items:
			for key,result in item.items():
				if key=='description':
					file_text = open(file_result, 'a')
					file_text.write(result+' ')
					file_text.close()

def get_result_file_xml(file,file_result):
	f = open(file_result, 'w')
	f.close()
	import xml.etree.ElementTree as ET
	parser = ET.XMLParser(encoding="utf-8")
	tree = ET.parse(file,parser)
	root = tree.getroot()
	xml_items = root.findall("channel/item")
	for xmli in xml_items:
		file_text = open(file_result, 'a')
		file_text.write(xmli.find("description").text+' ')
		file_text.close()

def long_words(filename):
    with open(filename) as f:
        words = (word.lower() for line in f for word in line.split() if len(word) > 6)
        for e in words:
            for char in punctuation:
                e = e.replace(char, "")
            yield e

get_result_file_json("z8/newsafr.json",'z8/result_file.txt')
counter = Counter(long_words('z8/result_file.txt'))
print(counter.most_common(10))

get_result_file_xml("z8/newsafr.xml",'z8/result_file.txt')
counter = Counter(long_words('z8/result_file.txt'))
print(counter.most_common(10))

