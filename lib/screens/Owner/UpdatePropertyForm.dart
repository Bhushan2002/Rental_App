import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rental_application/models/PropertyModel.dart';
import 'package:rental_application/widgets/InputFields.dart';

class UpdatePropertyForm extends StatefulWidget {
  final Property property;
  const UpdatePropertyForm({super.key, required this.property});

  @override
  State<UpdatePropertyForm> createState() => _UpdatePropertyFormState();
}

class _UpdatePropertyFormState extends State<UpdatePropertyForm> {
  @override
  Widget build(BuildContext context) {
    List<XFile> selectedImages = [];
    final ImagePicker imagePicker = ImagePicker();
    Future<void> pickImages() async {
      try {
        final List<XFile> images = await imagePicker.pickMultiImage(
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 80,
        );

        if (images.isNotEmpty) {
          setState(() {
            selectedImages.addAll(images);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking images: $e')));
      }
    }

    Future<void> removeImage(int index) async {
      setState(() {
        selectedImages.removeAt(index);
      });
    }

    final List<String> amenitiesList = [
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

    List<String> selectedAmenities = [];
    void toggleAmenity(String amenity) {
      setState(() {
        if (selectedAmenities.contains(amenity)) {
          selectedAmenities.remove(amenity);
        } else {
          selectedAmenities.add(amenity);
        }
      });
    }

    bool isAvailable = widget.property.isAvailable;

    // bool isLoading = false;

    return Scaffold(
      appBar: AppBar(title: Text('Update Property')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Property Type:",
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  SizedBox(width: 15),
                  Text(
                    widget.property.type.name,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: 'Title: ',
                hintText: widget.property.title,
              ),
              SizedBox(height: 24),
              BuiltTitleAndTextField(
                title: 'Description: ',
                hintText: widget.property.description,
              ),
              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: 'Price: ',
                hintText: widget.property.price.toString(),
              ),
              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: 'Street: ',
                hintText: widget.property.street,
              ),
              BuiltTitleAndTextField(
                title: 'City: ',
                hintText: widget.property.city,
              ),
              BuiltTitleAndTextField(
                title: 'state: ',
                hintText: widget.property.state,
              ),
              SizedBox(height: 28),

              Divider(),
              //property Details
              Text(
                'Property Details',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              SizedBox(height: 20),

              BuiltTitleAndTextField(
                title: 'Bedrooms: ',
                hintText: widget.property.bedrooms.toString(),
              ),

              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: 'Bathrooms: ',
                hintText: widget.property.bathrooms.toString(),
              ),

              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: "BHK",
                hintText: widget.property.bhk.toString(),
              ),

              SizedBox(height: 24),

              BuiltTitleAndTextField(
                title: 'Area',
                hintText: widget.property.area.toString(),
              ),

              SizedBox(height: 24),

              // amenities selector
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: amenitiesList.map((amenity) {
                  return FilterChip(
                    label: Text(
                      amenity,
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    selected: selectedAmenities.contains(amenity),
                    onSelected: (_) => toggleAmenity(amenity),
                    backgroundColor: Colors.grey[800],
                    selectedColor: Colors.blueGrey,
                    checkmarkColor: Colors.blue,
                  );
                }).toList(),
              ),

              SizedBox(height: 24),

              buildSectionTitle('Property Images *', context),
              ElevatedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text('Select Images'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(4),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (selectedImages.isEmpty)
                const Text(
                  'Please select at least one image',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.file(
                        File(selectedImages[index].path),
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
                            onPressed: () => removeImage(index),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Available for Rent'),
                value: isAvailable,
                onChanged: (value) {
                  setState(() {
                    isAvailable = value;
                  });
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // onPressed: _isLoading ? null : _submitForm,
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Post Property',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuiltTitleAndTextField extends StatelessWidget {
  final String hintText;
  final String title;
  const BuiltTitleAndTextField({
    super.key,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).primaryTextTheme.bodyMedium),
        SizedBox(height: 3),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hint: Text(hintText),
          ),
        ),
      ],
    );
  }
}
