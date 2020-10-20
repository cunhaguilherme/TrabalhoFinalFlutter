class Position {
  double lat;
  double lng;
  String circuit;
  String name;

  //construtor padrão
  Position({this.lat, this.lng, this.circuit, this.name});

  //cnostrutor nomeado
  Position.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'],
        circuit = json['circuit'],
        name = json['name'];
}
