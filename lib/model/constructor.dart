import 'package:cloud_firestore/cloud_firestore.dart';

class Constructor {

  final String name;
  final String brand;

  //referência do path do banco
  // / - raiz
  // /ford
  //cloud firestore = coleções e documentos
  DocumentReference reference;

  //construtor
  Constructor(this.name, this.brand);

  //construtor nomeado
  Constructor.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        brand = map['motor'];

  //construtor nomeado
  Constructor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'motor': brand,
      };

}