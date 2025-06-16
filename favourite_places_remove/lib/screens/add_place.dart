import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titleController = TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void savePlace() {
    final enteredTitle = titleController.text;
    if (enteredTitle.trim().isEmpty ||
        selectedImage == null ||
        selectedLocation == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(
          enteredTitle,
          selectedImage!,
          selectedLocation!,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añade nuevo lugar"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(label: Text("Título")),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) {
                selectedImage = image;
              },
            ),
            SizedBox(
              height: 10,
            ),
            LocationInput(
              onSelectLocation: (location) {
                selectedLocation = location;
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: Icon(Icons.add),
              label: Text("Añadir Lugar"),
            )
          ],
        ),
      ),
    );
  }
}
