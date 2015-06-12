import rhinoscriptsyntax as rs

def mapValue(val, inMin, inMax, outMin, outMax):
    outR = outMax - outMin
    inR = inMax - inMin
    inVal = val - inMin
    newVal = (inVal/inR) * outR
    return outMin + newVal

def lerp(startPt, endPt, T):
    len = rs.VectorSubtract(endPt, startPt)
    nVec = rs.VectorScale(len, T)
    return rs.VectorAdd(startPt, nVec)

def calcBiLinear(pt, bbMin, bbMax):
    bX = mapValue(pt.X,bbMin[0],bbMax[0],0.0,1.0)
    bY = mapValue(pt.Y,bbMin[1],bbMax[1],0.0,1.0)
    return[bX,bY]

def calcTriLinear(pt, bbMin, bbMax):
    bX = mapValue(pt.X,bbMin[0],bbMax[0],0.0,1.0)
    bY = mapValue(pt.Y,bbMin[1],bbMax[1],0.0,1.0)
    bZ = mapValue(pt.Z,bbMin[2],bbMax[2],0.0,1.0)
    return[bX,bY,bZ]

def main():
    #box = rs.GetBox()
    
    unitCubeMin = box[0]
    unitCubeMax = box[6]
    
    #units = rs.GetObjects("select polylines", 4)
    #meshes = rs.GetObjects("select meshes",32)
    
    for unit in units:
        unitPts = []
        unitCoords =[]
        
        polylinePts = rs.PolylineVertices(unit)
        
        print(str(polylinePts[0]))
        for pt in polylinePts:
            tc = calcTriLinear(pt,unitCubeMin,unitCubeMax)
            unitCoords.append(tc)
            unitPts.append(pt)
        
        for mesh in meshes:
            v = rs.MeshVertices(mesh)
            count = 0
         
            newPts = []
            for i in range(0, len(unitPts)):
                bLC = unitCoords[i]
                lX1 = lerp(v[4],v[5],bLC[0])
                lX2 = lerp(v[3],v[0] ,bLC[0])
                
                uX1 = lerp(v[6],v[7],bLC[0])
                uX2 = lerp(v[1],v[2],bLC[0])
                
                y1 = lerp(lX1,lX2,bLC[1])
                y2 = lerp(uX1,uX2,bLC[1])
                
                pt = lerp(y1,y2,bLC[2])
                rs.AddPoint(pt)
                newPts.append(pt)
                
            rs.AddPolyline(newPts)


if __name__ == "__main__":
    main()


