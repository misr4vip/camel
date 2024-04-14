import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/drawer_Widets.dart';

class OwnerMain extends StatefulWidget {
  const OwnerMain({super.key});

  @override
  State<OwnerMain> createState() => _OwnerMainState();
}

class _OwnerMainState extends State<OwnerMain> {
  String userName = "", userType = "", userPhone = "", userEmail = "";
  var controller = MapController();
  List<LatLng> points = [];
  var camelPosition = const LatLng(24.560566, 46.492646);
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userName = value.getString("userName") ?? "Guest";
        userType = value.getString("userType") ?? "Guest";
        userPhone = value.getString("userPhone") ?? "05xxx xxx";
        userEmail = value.getString("userEmail") ?? "someThing@gmail.com";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Helper(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _clearPoints(),
      //   child: const Icon(Icons.clear),
      // ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
            initialCenter: camelPosition,
            initialZoom: 12,
            onTap: (_, point) => _addPoints(point)),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          if (points.isNotEmpty)
            PolyWidgetLayer(polyWidgets: [
              PolyWidget(
                  center: points[0],
                  widthInMeters: 750,
                  heightInMeters: 750,
                  angle: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Column(
                      children: [
                        InkWell(
                          child: Text(""),
                          onTap: _clearPoints(),
                        ),
                        Text(
                          "Camels of $userName",
                          style:
                              const TextStyle(fontSize: 14, letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  )),
            ]),
          MarkerLayer(markers: [
            Marker(point: camelPosition, child: Image.asset("images/camel.png"))
          ])
        ],
      ),
    );
  }

  void _addPoints(LatLng latLng) {
    setState(() {
      points.add(latLng);
    });
  }

  _clearPoints() {
    setState(() {
      if (points.isNotEmpty) points.clear();
    });
  }
}


// pointA: LatLng(24.61154799431048 , 46.357562760812975),
// pointB: LatLng(24.554785069677457 , 46.40700148121266),
// approxPointC: LatLng(24.55910083239082 , 46.407750427120746),

//   PolygonLayer(polygons: [Polygon(
//   points: points,
//   color: Colors.transparent,
//   borderColor: Colors.blue,
//   borderStrokeWidth: 3.0,
//   isFilled: true,
// )], ),