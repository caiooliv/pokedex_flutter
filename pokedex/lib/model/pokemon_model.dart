class Pokemon {
  String name ;
  List types,stats;
  int weight, height, id;


  Pokemon({this.name, this.weight,this.height,this.stats,this.types});

   Pokemon.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    types = json['types'];
    stats = json['stats'];    
    weight = json['weight'];
    height = json['height'];
    id = json['id'];
  }



}
