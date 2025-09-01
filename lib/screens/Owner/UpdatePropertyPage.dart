import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_application/PropertyData/property_controller.dart';
import 'package:rental_application/models/PropertyModel.dart';

class UpdatePropertyPage extends ConsumerStatefulWidget {
  final Property property;
  const UpdatePropertyPage({super.key, required this.property});

  @override
  ConsumerState createState() => _UpdatePropertyPageState();
}

class _UpdatePropertyPageState extends ConsumerState<UpdatePropertyPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _bhkController = TextEditingController();
  final _areaController = TextEditingController();

  // Apartment specific controllers
  final _floorController = TextEditingController();
  final _apartmentNumberController = TextEditingController();

  // House specific controllers
  final _floorsController = TextEditingController();
  final _landAreaController = TextEditingController();

  PropertyType _selectedType = PropertyType.Apartment;
  List<String> _selectedAmenities = [];
  List<XFile> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  bool _hasElevator = false;
  bool _hasSecurity = false;
  bool _hasParking = false;
  bool _hasBalcony = false;
  bool _hasGarden = false;
  bool _hasPool = false;
  bool _isFurnished = false;
  bool _isAvailable = true;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final Map<String, dynamic> formData = {
        'type': _selectedType.name,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'location': _locationController.text,
        'bedrooms': int.parse(_bedroomsController.text),
        'bathrooms': int.parse(_bathroomsController.text),
        'bhk': int.parse(_bhkController.text),
        'area': double.parse(_areaController.text),
        'isAvailable': _isAvailable,
        'amenities': _selectedAmenities,
        'images': _selectedImages.map((img) => File(img.path)).toList(),
        // Apartment-specific fields
        'floor': int.tryParse(_floorController.text) ?? 0,
        'apartmentNumber': _apartmentNumberController.text,
        'hasElevator': _hasElevator,
        'hasSecurity': _hasSecurity,
        'hasParking': _hasParking,
        'hasBalcony': _hasBalcony,
        // House-specific fields
        'floors': int.tryParse(_floorsController.text) ?? 1,
        'landArea': double.tryParse(_landAreaController.text) ?? 0.0,
        'hasGarden': _hasGarden,
        'hasPool': _hasPool,
        'isFurnished': _isFurnished,
      };

      // ref
      //     .read(propertyControllerProvider.notifier)
      //     .addProperty(
      //       formData: formData,
      //       onError: (error) {
      //         if (mounted) {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(
      //               content: Text(error),
      //               backgroundColor: Colors.redAccent,
      //             ),
      //           );
      //         }
      //       },
      //     )
      //     .then((success) {
      //       if (success && mounted) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(
      //             content: Text('Property added successfully!'),
      //             backgroundColor: Colors.green,
      //           ),
      //         );
      // }
      // });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.property.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.property.images[0],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.property.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              widget.property.location,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              "₹${widget.property.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Text(
              "Property Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "This is a beautiful property located in a prime area. "
              "It has modern facilities, great design, and easy access to all amenities.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
