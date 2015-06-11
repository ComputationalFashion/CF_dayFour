import rhinoscriptsyntax as rs
import scriptcontext
import System.Guid
import Rhino

filter = "TXT (*.txt)|*.txt"
filename = rs.OpenFileName("Select curve file", filter)

file = open(filename, 'r')
lines = file.readlines()
file.close()

deg = rs.GetReal("set curve degree",3)

for line in lines:
    
    pts = []
    strings = line.split('/')
    points = Rhino.Collections.Point3dList(len(strings))
    for string in strings:
        pos = rs.Str2Pt(string)
        
        points.Add(pos[0], pos[1], pos[2])
    nc = Rhino.Geometry.NurbsCurve.Create(False, deg, points)
    rc = Rhino.Commands.Result.Failure
    if nc and nc.IsValid:
        if scriptcontext.doc.Objects.AddCurve(nc)!=System.Guid.Empty:
            scriptcontext.doc.Views.Redraw()
            rc = Rhino.Commands.Result.Success
    
    