import rhinoscriptsyntax as rs

filter = "TXT (*.txt)|*.txt"
filename = rs.OpenFileName("Select tick file", filter)

file = open(filename, 'r')
lines = file.readlines()
file.close()

for line in lines:
    pos = line.split(',')
    if len(pos) > 6:
        x = float(pos[0])
        y = float(pos[1])
        z = float(pos[2])
        x2 = float(pos[3])
        y2 = float(pos[4])
        z2 = float(pos[5])
        r = float(pos[6])
        g = float(pos[7])
        b = float(pos[8])
        line = rs.AddLine([x,y,z], [x2,y2,z2])
        rs.ObjectColor(line, [r,g,b])
    else:
        x = float(pos[0])
        y = float(pos[1])
        z = float(pos[2])
        x2 = float(pos[3])
        y2 = float(pos[4])
        z2 = float(pos[5])
        r = float(pos[6])
        g = float(pos[7])
        b = float(pos[8])
        line = rs.AddLine([x,y,z], [x2,y2,z2])
        rs.ObjectColor(line, [r,g,b])
    