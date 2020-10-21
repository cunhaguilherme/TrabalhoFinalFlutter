import 'package:floor/floor.dart';

//annotation entity indica pro flutter a presença de uma entidade
@entity
class Legend {
  @PrimaryKey(autoGenerate: true)
  int id;

  final String name;
  final String nacionality;
  final String championshipsWon;

  //construtor com parâmetros opcionais (uso das chaves)
  Legend({this.id, this.name, this.nacionality, this.championshipsWon});
}
