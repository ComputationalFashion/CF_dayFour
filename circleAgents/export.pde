PrintWriter output;

void exportCrv(){
  output = createWriter("crvs.txt");
  for(int i = 0; i < agents.size(); i++){
    agent a = (agent) agents.get(i);
    for(int j = 0; j < a.history.size(); j++){
      PVector pos = (PVector) a.history.get(j);
      output.print(pos.x + "," + pos.y +"," + j);
      if(j < a.history.size() -1){
        output.print("/");
      }
    }
    output.println();
  }
  output.flush();
  output.close();
}
