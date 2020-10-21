import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/listDrivers.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/listTrucks.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/listLegends.dart';
import 'package:flutter_fiap_aula_http_mapas/core/push_notification_configure.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/listConstructors.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/mapa.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/home.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/addDriver.dart';
import 'package:flutter_fiap_aula_http_mapas/screens/addConstructor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationConfigure().configure();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/grandprix': (context) => ListTrucks(),
        '/pilotos': (context) => ListDrivers(),
        '/lendas': (context) => ListLegends(),
        '/construtores': (context) => ListConstructors(),
        '/mapa': (context) => Mapa(),
      },
    );
  }
}
