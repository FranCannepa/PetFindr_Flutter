import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petfindr/UI/Widgets/ReportForm.dart';
import 'package:image_picker/image_picker.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);

  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  Position? _currentPosition;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position?>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ReportForm(_currentPosition),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            );
            ;
          } else if (snapshot.hasError) {
            return Text('Error fetching location: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<Position?>? _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentPosition = position;
      });
      return _currentPosition;
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
