class Surface{
    ArrayList<Vec2> surface; 
    
    Surface(){
      surface = new ArrayList<Vec2>(); 
      
      surface.add(new Vec2(0, 0));
      surface.add(new Vec2(-10, height-10)); 
      surface.add(new Vec2(width+10, height-10));
      surface.add(new Vec2(width+10, 0));
    //  surface.add(new Vec2(0, height-10));
      //surface.add(new Vec2(width+10, height-10));
      
      ChainShape chain = new ChainShape(); 
      Vec2[] vertices = new Vec2[surface.size()];
    
      for (int i = 0; i < vertices.length; i++) {//Convert each vertex to Box2D World coordinates.
        vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
      }
      chain.createChain(vertices, vertices.length);
      BodyDef bd = new BodyDef();
      Body body = box2d.world.createBody(bd);
      body.createFixture(chain, 1);        
  }
  void display(){
    strokeWeight(1);
    stroke(0);
    noFill();
    
    //Draw the ChainShape as a series of vertices.
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    endShape();
  }
}
