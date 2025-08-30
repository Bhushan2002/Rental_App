import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_application/PropertyData/property_controller.dart';

import 'package:rental_application/models/PropertyModel.dart';
import 'package:rental_application/screens/Owner/CreatedProperty.dart';
import 'package:rental_application/screens/Owner/OwnerNavbarScreen.dart';
import 'package:rental_application/widgets/InputFields.dart';

class PostPropertyForm extends ConsumerStatefulWidget {
  const PostPropertyForm({super.key});

  @override
  ConsumerState<PostPropertyForm> createState() => _PostPropertyFormState();
}

class _PostPropertyFormState extends ConsumerState<PostPropertyForm> {
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

  // Boolean toggles
  bool _hasElevator = false;
  bool _hasSecurity = false;
  bool _hasParking = false;
  bool _hasBalcony = false;
  bool _hasGarden = false;
  bool _hasPool = false;
  bool _isFurnished = false;
  bool _isAvailable = true;
  bool _isLoading = false;

  // Amenities list
  final List<String> _amenitiesList = [
    'Wi-Fi',
    'Air Conditioning',
    'Heating',
    'TV',
    'Washing Machine',
    'Dryer',
    'Microwave',
    'Refrigerator',
    'Dishwasher',
    'Balcony',
    'Garden',
    'Swimming Pool',
    'Gym',
    'Parking',
    'Security',
    'Elevator',
    'Pet Friendly',
    'Furnished',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _bhkController.dispose();
    _areaController.dispose();
    _floorController.dispose();
    _apartmentNumberController.dispose();
    _floorsController.dispose();
    _landAreaController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking images: $e')));
    }
  }

  Future<void> _removeImage(int index) async {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _toggleAmenity(String amenity) {
    setState(() {
      if (_selectedAmenities.contains(amenity)) {
        _selectedAmenities.remove(amenity);
      } else {
        _selectedAmenities.add(amenity);
      }
    });
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter valid $fieldName';
    }
    return null;
  }

  String? _validateInteger(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final integer = int.tryParse(value);
    if (integer == null || integer <= 0) {
      return 'Please enter valid $fieldName';
    }
    return null;
  }

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

      ref
          .read(propertyControllerProvider.notifier)
          .addProperty(
            formData: formData,
            onError: (error) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
          )
          .then((success) {
            if (success && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Property added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatedProperty()),
                );
              }
            }
          });
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSectionTitle('Property Type', context),
                    DropdownButtonFormField<PropertyType>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        // labelText: 'Property Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: PropertyType.values.map((type) {
                        return DropdownMenuItem<PropertyType>(
                          value: type,
                          child: Text(
                            type.toString().split('.').last.toUpperCase(),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Basic Information
                    buildSectionTitle('Basic Information', context),
                    buildTextFormField(
                      controller: _titleController,
                      tstyle:
                          Theme.of(context).primaryTextTheme.bodyMedium
                              as TextStyle,
                      label: 'Property Title *',
                      validator: (value) => _validateRequired(value, 'title'),
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _descriptionController,
                      tstyle:
                          Theme.of(context).primaryTextTheme.bodyMedium
                              as TextStyle,
                      label: 'Description *',
                      maxLines: 3,
                      validator: (value) =>
                          _validateRequired(value, 'description'),
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _priceController,
                      tstyle:
                          Theme.of(context).primaryTextTheme.bodyMedium
                              as TextStyle,
                      label: 'Price (\$) *',
                      keyboardType: TextInputType.number,
                      validator: (value) => _validateNumber(value, 'price'),
                    ),
                    const SizedBox(height: 12),
                    buildTextFormField(
                      controller: _locationController,
                      tstyle:
                          Theme.of(context).primaryTextTheme.bodyMedium
                              as TextStyle,
                      label: 'Location *',
                      validator: (value) =>
                          _validateRequired(value, 'location'),
                    ),

                    const SizedBox(height: 24),

                    // Property Details
                    buildSectionTitle('Property Details', context),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextFormField(
                            controller: _bedroomsController,
                            tstyle:
                                Theme.of(context).primaryTextTheme.bodyMedium
                                    as TextStyle,
                            label: 'Bedrooms *',
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                _validateInteger(value, 'bedrooms'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: buildTextFormField(
                            controller: _bathroomsController,
                            label: 'Bathrooms *',
                            tstyle:
                                Theme.of(context).primaryTextTheme.bodyMedium
                                    as TextStyle,
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                _validateInteger(value, 'bathrooms'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextFormField(
                            controller: _bhkController,
                            tstyle:
                                Theme.of(context).primaryTextTheme.bodyMedium
                                    as TextStyle,
                            label: 'BHK *',
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                _validateInteger(value, 'BHK'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: buildTextFormField(
                            controller: _areaController,
                            label: 'Area (sq ft) *',
                            keyboardType: TextInputType.number,
                            tstyle:
                                Theme.of(context).primaryTextTheme.bodyMedium
                                    as TextStyle,
                            validator: (value) =>
                                _validateNumber(value, 'area'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Type Specific Fields
                    buildSectionTitle(
                      '${_selectedType.toString().split('.').last.toUpperCase()} Details',
                      context,
                    ),
                    if (_selectedType == PropertyType.Apartment)
                      _buildApartmentFields(),
                    if (_selectedType == PropertyType.House)
                      _buildHouseFields(),

                    const SizedBox(height: 24),

                    // Amenities
                    buildSectionTitle('Amenities', context),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _amenitiesList.map((amenity) {
                        return FilterChip(
                          label: Text(
                            amenity,
                            style: Theme.of(context).primaryTextTheme.bodySmall,
                          ),
                          selected: _selectedAmenities.contains(amenity),
                          onSelected: (_) => _toggleAmenity(amenity),
                          backgroundColor: Colors.grey[800],
                          selectedColor: Colors.blueGrey,
                          checkmarkColor: Colors.blue,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Images
                    buildSectionTitle('Property Images *', context),
                    ElevatedButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Select Images'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedImages.isEmpty)
                      const Text(
                        'Please select at least one image',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Image.file(
                              File(_selectedImages[index].path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _removeImage(index),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Availability
                    buildSectionTitle('Availability', context),
                    SwitchListTile(
                      title: const Text('Available for Rent'),
                      value: _isAvailable,
                      onChanged: (value) {
                        setState(() {
                          _isAvailable = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Post Property',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildApartmentFields() {
    return Column(
      children: [
        buildTextFormField(
          controller: _floorController,
          tstyle: Theme.of(context).primaryTextTheme.bodyMedium as TextStyle,
          label: 'Floor Number *',
          keyboardType: TextInputType.number,
          validator: (value) => _validateInteger(value, 'floor number'),
        ),
        const SizedBox(height: 12),
        buildTextFormField(
          controller: _apartmentNumberController,
          tstyle: Theme.of(context).primaryTextTheme.bodyMedium as TextStyle,
          label: 'Apartment Number *',
          validator: (value) => _validateRequired(value, 'apartment number'),
        ),
        const SizedBox(height: 12),
        CheckboxListTile(
          title: const Text('Has Elevator'),
          value: _hasElevator,
          onChanged: (value) => setState(() => _hasElevator = value!),
        ),
        CheckboxListTile(
          title: const Text('Has Security'),
          value: _hasSecurity,
          onChanged: (value) => setState(() => _hasSecurity = value!),
        ),
        CheckboxListTile(
          title: const Text('Has Parking'),
          value: _hasParking,
          onChanged: (value) => setState(() => _hasParking = value!),
        ),
        CheckboxListTile(
          title: const Text('Has Balcony'),
          value: _hasBalcony,
          onChanged: (value) => setState(() => _hasBalcony = value!),
        ),
      ],
    );
  }

  Widget _buildHouseFields() {
    return Column(
      children: [
        buildTextFormField(
          controller: _floorsController,
          tstyle: Theme.of(context).primaryTextTheme.bodyMedium as TextStyle,
          label: 'Number of Floors *',
          keyboardType: TextInputType.number,
          validator: (value) => _validateInteger(value, 'number of floors'),
        ),
        const SizedBox(height: 12),
        buildTextFormField(
          controller: _landAreaController,
          label: 'Land Area (sq ft) *',
          tstyle: Theme.of(context).primaryTextTheme.bodyMedium as TextStyle,
          keyboardType: TextInputType.number,
          validator: (value) => _validateNumber(value, 'land area'),
        ),
        const SizedBox(height: 12),
        CheckboxListTile(
          title: const Text('Has Garden'),
          value: _hasGarden,
          onChanged: (value) => setState(() => _hasGarden = value!),
        ),
        CheckboxListTile(
          title: const Text('Has Pool'),
          value: _hasPool,
          onChanged: (value) => setState(() => _hasPool = value!),
        ),
        CheckboxListTile(
          title: const Text('Is Furnished'),
          value: _isFurnished,
          onChanged: (value) => setState(() => _isFurnished = value!),
        ),
      ],
    );
  }
}
