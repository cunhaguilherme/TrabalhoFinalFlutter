import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_fiap_aula_http_mapas/dao/legend_dao.dart';
import 'package:flutter_fiap_aula_http_mapas/model/legend.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Legend])
abstract class AppDatabase extends FloorDatabase {
  LegendDao get legendDao;
}
