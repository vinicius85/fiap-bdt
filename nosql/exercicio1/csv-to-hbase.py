import os.path
import sys

inputFile = sys.argv[1]
with open(inputFile,'r') as f: 
	
	tableName = inputFile.split('.')[0]
	
	searchStr = "create '"+tableName+"' , 'CF_Data', 'CF_Meta', 'CF_Rank'"
	
	input = f.readline()
	rowkey = input.split(',')[2].strip()
	
	putCmdList = ""
	
	for line in f:
		tokens = line.split(',')
		putCmdList = putCmdList + "put '"+tableName+"','"+rowkey+"','"+tokens[0]+":"+tokens[1]+"','"+tokens[2].strip()+"'\n"
		
			
filename = "output/"+tableName+"-hbase.csv"

if not os.path.exists(os.path.dirname(filename)):
    os.makedirs(os.path.dirname(filename), 0777)

with open(filename,'w+') as g:
	g.write(searchStr)
	g.write('\n')
	g.write(putCmdList)
	
