import rhinoscriptsyntax as rs

filter = "TXT (*.txt)|*.txt"
filename = rs.OpenFileName("Select point file", filter)

file = open(filename, 'r')
lines = file.readlines()
file.close()

for line in lines:
    pos = line.split(',')
    if len(pos) > 3:
        x = float(pos[0])
        y = float(pos[1])
        z = float(pos[2])
        r = float(pos[3])
        g = float(pos[4])
        b = float(pos[5])
        pt = rs.AddPoint([x,y,z])
        rs.ObjectColor(pt, [r,g,b])
    else:
        x = float(pos[0])
        y = float(pos[1])
        z = float(pos[2])
        rs.AddPoint([x,y,z])
    