import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/model/driver.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'addDriver.dart';

class ListDrivers extends StatefulWidget {
  @override
  _ListDriversState createState() => _ListDriversState();
}

//StatelessWidget ou State pra ter acesso a função build
class _ListDriversState extends State<ListDrivers> {
  Database _database;
  List<Driver> driversList = List<Driver>();

  //ele faz parte do ciclo de vida do state - StatefulWidget
  @override
  void initState() {
    super.initState();

    //como o ciclo de todo State começa no initState
    //é neste ponto que nós camos abrir a conexão com o banco de dados
    getDatabase();
  }

  getDatabase() async {
    //SQLITE - usando o mais crú possível
    //Floor - Room
    openDatabase(join(await getDatabasesPath(), 'driver_database.db'),
            onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE driver(id INTEGER PRIMARY KEY, name TEXT, nacionality TEXT, age TEXT)",
      );
    }, version: 1)
        .then((db) {
      setState(() {
        _database = db;
      });

      readAll();
    });
  }

  readAll() async {
    //quando encontramos a palavra reservada await, estamos em uma função
    //assíncrona
    //sempre que uma linha usa await, a sua função pai precisa ter o async
    final List<Map<String, dynamic>> maps = await _database.query('driver');

    driversList = List.generate(maps.length, (i) {
      return Driver(
          id: maps[i]['id'],
          name: maps[i]['name'],
          nacionality: maps[i]['nacionality'],
          age: maps[i]['age']);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("F1 Friends - Lista de Pilotos"),
        actions: <Widget>[
          if (_database != null)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDriver()))
                    .then((newDriver) {
                  if (newDriver != null) {
                    insertDriver(newDriver);
                  }
                });
              },
            )
        ],
      ),
      body: ListView.separated(
        itemCount: driversList.length,
        itemBuilder: (context, index) => buildListItem(index),
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
      ),
    );
  }

  Widget buildListItem(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        //BoxDecoration insere os cantos arredondados
        //Usando BoxDecoration vc pode estilizar com bem entender
        //ex: fundo degradee
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text("${driversList[index].id}"),
          title: Text(driversList[index].name),
          subtitle: Text(
              "${driversList[index].nacionality}, ${driversList[index].age}"),
          onLongPress: () {
            deleteDriver(index);
          },
        ),
      ),
    );
  }

  insertDriver(Driver driver) {
    _database
        .insert(
      'driver',
      driver.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) {
      driver.id = value;
      setState(() {
        driversList.add(driver);
      });
    });
  }

  deleteDriver(int index) {
    _database.delete(
      'driver', //table
      where:
          "id = ?", //where "id = ?" - sql injection - hacker/crackers usam para zoar bancos
      whereArgs: [driversList[index].id], //argumentos do where
    ).then((value) {
      setState(() {
        driversList.removeAt(index);
      });
    });
  }
}
