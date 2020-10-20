import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_http_mapas/model/position.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;

class ListItemVehicle extends StatefulWidget {
  final Position position;

  ListItemVehicle(this.position);

  @override
  _ListItemVehicleState createState() => _ListItemVehicleState();
}

class _ListItemVehicleState extends State<ListItemVehicle> {
  TextStyle style15dp = TextStyle(fontSize: 15);
  TextStyle style27dp = TextStyle(fontSize: 27);
  Geolocator.Placemark placemark;

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  getAddress() async {
    List<Geolocator.Placemark> listPlacemarks = await Geolocator.Geolocator()
        .placemarkFromCoordinates(widget.position.lat, widget.position.lng);

    //for class pattern
    setState(() {
      placemark = listPlacemarks[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  //expanded: obriga a widget a expandir até o espaço possível
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.position.circuit.trim(), style: style27dp),
                      Text(
                          widget.position.name == null
                              ? "-"
                              : widget.position.name,
                          style: style15dp),
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/mapa", arguments: widget.position);
          },
        ));
  }

  String getFormattedAddress() {
    return "${placemark.subAdministrativeArea}, ${placemark.administrativeArea}";
  }
}
