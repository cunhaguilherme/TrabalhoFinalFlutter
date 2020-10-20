import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/addConstructor.dart';
import 'package:flutter_fiap_aula_http_mapas/model/constructor.dart';

class ListConstructors extends StatefulWidget {
  @override
  _ListConstructorsState createState() => _ListConstructorsState();
}

class _ListConstructorsState extends State<ListConstructors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Construtores"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Future<Constructor> future = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddConstructor(),
                  ));
              future.then((constructor) {
                if (constructor != null) insertCar(constructor);
              });
            },
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  insertCar(Constructor constructor){
    Firestore.instance.collection('constructor').add(constructor.toJson());
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('constructor').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Constructor.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.brand),
          onLongPress: (){
            data.reference.delete();
          },
        ),
      ),
    );
  }
}