import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'listTrucks.dart';

class Home extends StatelessWidget {
  static const String _title = 'F1 Friends - Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: Menu(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class Menu extends StatelessWidget {
  Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.assistant_photo),
              title: Text('Grandprix 2020'),
              subtitle: Text(
                  'Clique aqui e verifique todos os grandprix da F1 da temporada 2020.'),
              onTap: () {
                Navigator.pushNamed(context, "/grandprix");
                callAlertMessage("Carregando circuitos...");
              },
            ),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Pilotos'),
                subtitle: Text(
                    'Clique aqui e adicione os pilotos que desejar para a atual temporada.'),
                onTap: () {
                  Navigator.pushNamed(context, "/pilotos");
                  callAlertMessage("Carregando pilotos...");
                }),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.build),
                title: Text('Construtores'),
                subtitle: Text('Clique aqui e insira os construtores .'),
                onTap: () {
                  Navigator.pushNamed(context, "/construtores");
                  callAlertMessage("Carregando construtores...");
                }),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.grade),
                title: Text('Lendas'),
                subtitle: Text(
                    'Clique aqui e contemple as maiores lendas de todos os tempos da F1.'),
                onTap: () {
                  Navigator.pushNamed(context, "/lendas");
                  callAlertMessage("Carregando lendas...");
                }),
          ],
        ),
      ),
    );
  }

  Widget retornaDivider() {
    return Divider(
      color: Colors.lightBlue,
      height: 20,
      thickness: 2,
      indent: 20,
      endIndent: 0,
    );
  }
}

Future<Null> callAlertMessage(String msg) async {
  var platformMethodChannel = const MethodChannel('com.test/test');
  await platformMethodChannel.invokeMethod('showAlert', {'msg': msg});
}
