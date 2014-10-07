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
		rowkey = ""
		for i in range(len(tokens)):
			if(cols[i]=="rowkey"):
				rowkey  = "'"+tokens[i].strip()+"' ,"
			else:
				putCmd = rowkey+ ", '"+cols[i]+"','"+tokens[i].strip()+"'\n"
		putCmdList = putCmdList + putCmd

	with open('search-hbase.csv','r+') as g:
		g.write(createSearch)
		g.write('\n')
		g.write(putCmdList)
	
