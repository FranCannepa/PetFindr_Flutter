import 'package:flutter/material.dart';
import 'package:petfindr/UI/Widgets/ReportForm.dart';
import 'package:image_picker/image_picker.dart';

class NewReport extends StatefulWidget {
  const NewReport({Key? key}) : super(key: key);

  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  String? selectedType;
  String? selectedCategory;
  String? selectedBreed;
  String? selectedSize;
  XFile? selectedPhoto;

  final List<String> types = ['Lost', 'Found'];
  final List<String> categories = ['Dog', 'Cat'];
  final Map<String, List<String>> breeds = {
    'Dog': [
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
    'Cat': [
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

  final List<String> sizes = ['Small', 'Medium', 'Big'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ReportForm(),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
