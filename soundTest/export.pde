PrintWriter output;

void exportPts(){
  output = createWriter("pts.txt");
  for(int i = 0; i < vals.length; i++){
    for(int j = 0; j < vals[i].length; j++){
      float x = i*res;
      float y = j*res;
      output.println(x + "," + y +"," + vals[i][j]);
    }
  }
  output.flush();
  output.close();
  
}
