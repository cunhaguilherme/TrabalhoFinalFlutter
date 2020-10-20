import 'package:flutter/material.dart';

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
  static const IconData emoji_events =
      IconData(0xe6f5, fontFamily: 'MaterialIcons');

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
              },
            ),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Pilotos'),
                subtitle:
                    Text('Clique aqui e confira os pilotos da temporada 2020.'),
                onTap: () {
                  Navigator.pushNamed(context, "/pilotos");
                }),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.build),
                title: Text('Construtores'),
                subtitle: Text(
                    'Clique aqui e fique sabendo quem são os pilotos que estarão competindo pelo título mundial de F1 2020.'),
                onTap: () {
                  Navigator.pushNamed(context, "/construtores");
                }),
            retornaDivider(),
            ListTile(
                leading: Icon(Icons.grade),
                title: Text('Lendas'),
                subtitle: Text(
                    'Clique aqui e contemple as maiores lendas de todos os tempos da F1.'),
                onTap: () {
                  Navigator.pushNamed(context, "/lendas");
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
