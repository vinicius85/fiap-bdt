import os.path

with open('search.csv','r') as f: 
	
	input = f.readline()
	colFamilies = input.split(',')
	
	searchStr = "create 'search' , '{}', '{}', '{}'"
	createSearch = searchStr.format(colFamilies[1],colFamilies[2],colFamilies[3].strip())
	
	colLine = f.readline()
	cols = colLine.split(',')
	
	putCmdList = ""
	
	for line in f:
		
		tokens = line.split(',')
		putCmd = "put 'search', "
		rowkey = tokens[0]
		
		for i in range(1,len(tokens)):
			putCmd = rowkey+ ", '"+cols[i-1]+"','"+tokens[i].strip()+"'"
		putCmdList = putCmdList + putCmd
	
filename = "output/search-hbase.csv"

if not os.path.exists(os.path.dirname(filename)):
    os.makedirs(os.path.dirname(filename), 0777)

with open(filename,'w+') as g:
	g.write(createSearch)
	g.write('\n')
	g.write(putCmdList)
	
