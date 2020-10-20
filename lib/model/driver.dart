class Driver {
  int id;
  final String name;
  final String nacionality;
  final String age;

  Driver({this.id, this.name, this.nacionality, this.age});

  //no Flutter.. vc faz parser de json-objetos e de objetos-json
  //usando uma instância de Map
  //dynamic: no DART, é uma tipagem fraca, que aceita qualquer coisa
  //isso foi necessário, porque o pacote de sqlite trabalha com json na
  //inserção e na leitura
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nacionality': nacionality,
      'age': age,
    };
  }
}
