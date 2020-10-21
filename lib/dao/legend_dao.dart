import 'package:floor/floor.dart';
import 'package:flutter_fiap_aula_http_mapas/model/legend.dart';

@dao
abstract class LegendDao {
  @Query('SELECT * FROM Legend')
  Future<List<Legend>> findAll();

  @insert
  Future<int> insertLegend(Legend legend);

  @delete
  Future<int> deleteLegend(Legend legend);
}
