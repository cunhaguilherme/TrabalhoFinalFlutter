import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/addLegend.dart';
import 'package:flutter_fiap_aula_http_mapas/dao/legend_dao.dart';
import 'package:flutter_fiap_aula_http_mapas/database/app_database.dart';
import 'package:flutter_fiap_aula_http_mapas/model/legend.dart';

class ListLegends extends StatefulWidget {
  @override
  _ListLegendsState createState() => _ListLegendsState();
}

class _ListLegendsState extends State<ListLegends> {
  LegendDao legendDAO;
  List<Legend> listLegends = List();

  //ciclo de vida do State. Ele vai ser chamado no início,
  //e apenas uma vez
  @override
  void initState() {
    super.initState();
    openDatabase();
  }

  openDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    legendDAO = database.legendDao;
    legendDAO.findAll().then((value) => listLegends = value);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("F1 Friends - Lista de Lendas"),
        actions: <Widget>[
          if (legendDAO != null)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Future<Legend> future = Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddLegend(),
                    ));
                future.then((legend) {
                  if (legend != null) {
                    legendDAO.insertLegend(legend).then((value) {
                      if (value > 0) {
                        setState(() {
                          legend.id = value;
                          listLegends.add(legend);
                        });
                      }
                    });
                  }
                });
              },
            )
        ],
      ),
      body: ListView.separated(
        itemCount: listLegends.length,
        itemBuilder: (context, index) => buildListItem(listLegends[index]),
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
      ),
    );
  }

  Widget buildListItem(Legend legend) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text("${legend.id}"),
          title: Text(legend.name),
          subtitle: Text(legend.nacionality + " - " + legend.championshipsWon),
          onLongPress: () {
            deleteLegend(legend);
          },
        ),
      ),
    );
  }

  deleteLegend(Legend legend) {
    legendDAO.deleteLegend(legend).then((value) {
      if (value == 1) {
        setState(() {
          listLegends.remove(legend);
        });
      }
    });
  }
}
