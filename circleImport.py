import rhinoscriptsyntax as rs

filename = rs.OpenFileName('select text file')

file = open(filename, 'r')

lines = file.readlines()

for line in lines:
    pos = line.split(',')
    x = float(pos[0])
    y = float(pos[1])
    rad = float(pos[2])
    rs.AddCircle([x,y,0], rad*2)
    
