import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ReportDetailed extends StatelessWidget {
  final Map<String, dynamic> reportData;
  const ReportDetailed({Key? key, required this.reportData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 10,
              initialCenter:
                  LatLng(reportData['coordinates'], reportData['coordinates']),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
