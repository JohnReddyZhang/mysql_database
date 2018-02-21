fhandle = open('tables.txt','r')
outhandle = open('output.sql','w')
for line in fhandle:
    outhandle.write(f'SELECT \'{line.strip()}\' TableName, COUNT(*) Count\nFROM {line}')
    outhandle.write('UNION ALL\n')
fhandle.close()
outhandle.close()
