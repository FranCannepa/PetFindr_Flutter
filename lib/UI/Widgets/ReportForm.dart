import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:petfindr/UI/Widgets/CustomSubmitButton.dart';

final _formKey = GlobalKey<FormState>();

class ReportForm extends StatefulWidget {
  const ReportForm(Position? currentPosition, {Key? key}) : super(key: key);
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  XFile? selectedPhoto;
  String? selectedType;
  XFile? _imageFile = null;
  Position? _currentPosition;
  LatLng? selectedLocation;
  String? selectedCategory;
  String? selectedBreed;
  String? selectedSize;

  late MapController mapController = MapController();

  final List<String> types = ['Perdido', 'Encontrado'];
  final List<String> categories = ['Perro', 'Gato'];
  final Map<String, List<String>> breeds = {
    'Perro': [
      'Labrador',
      'Golden Retriever',
      'German Shepherd',
      'Bulldog',
      'Poodle',
      'Beagle',
      'Boxer',
      'Dachshund',
      'Siberian Husky',
    ],
    'Gato': [
      'Siamese',
      'Persian',
      'Maine Coon',
      'Ragdoll',
      'British Shorthair',
      'Sphynx',
      'Bengal',
      'Abyssinian',
      'Scottish Fold',
    ],
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            value: selectedType,
            items: types
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                selectedType = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Perdido o Encontrado',
            ),
            style: TextStyle(color: Colors.black),
            dropdownColor: Colors.white,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            items: categories
                .map((category) =>
                    DropdownMenuItem(value: category, child: Text(category)))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                selectedCategory = value;
                selectedBreed = null;
              });
            },
            decoration: InputDecoration(
              labelText: 'Perro o Gato',
            ),
            style: TextStyle(color: Colors.black),
            dropdownColor: Colors.white,
          ),
          SizedBox(height: 16),
          if (selectedCategory != null)
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: selectedBreed,
              items: breeds[selectedCategory!]!
                  .map((breed) =>
                      DropdownMenuItem(value: breed, child: Text(breed)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBreed = value;
                });
              },
              style: TextStyle(color: Colors.black),
              decoration:
                  InputDecoration(labelText: 'Raza', fillColor: Colors.white),
            ),
          SizedBox(
            width: 100,
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialZoom: 10,
                      initialCenter: _currentPosition != null
                          ? LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude)
                          : LatLng(0, 0),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: 20.0,
            child: Align(
              widthFactor: 1.0,
              child: InkWell(
                onTap: () async {
                  final XFile? image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imageFile = image;
                    });
                  }
                },
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: _imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(_imageFile!.path),
                              height: 50.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            child: const Center(
                              child: Text(
                                "No image selected",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          CustomSubmitButton(
            texto: "Ingresar",
            //onTap: submitReport,
          ),
        ],
      ),
    );
  }

  void _setImageFile(XFile? value) {
    if (value != null) {
      setState(() {
        _imageFile = value;
      });
    }
  }

  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      _setImageFile(pickedFile);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
