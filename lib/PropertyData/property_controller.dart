

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/Property_repository.dart';
import 'package:rental_application/models/ApartmentModel.dart';
import 'package:rental_application/models/HousesModel.dart';
import 'package:rental_application/models/PropertyModel.dart';
import 'package:uuid/uuid.dart';

class PropertyController extends StateNotifier<bool> {
  final PropertyRepository _propertyRepository;
  final String? _ownerId;
  PropertyController({
    required PropertyRepository propertyRepository,
    required String? ownerId,
  }) : _propertyRepository = propertyRepository,
       _ownerId = ownerId,

       super(false);

  Future<bool> addProperty({
    required Map<String, dynamic> formData,
    required Function(String) onError,
  }) async {
    if (_ownerId == null) {
      onError('You must be logged in to post a property.');
      return false;
    }

    state = true; // Start loading
    bool success = false;
    try {
      final propertyId = const Uuid().v4();

      // 1. Upload images and get their URLs
      // final List<File> images = formData['images'];
      // final List<String> imageUrls = await _propertyRepository.uploadImages(images, propertyId);

      // 2. Create the correct Property object based on the type
      Property property;
      PropertyType type = formData['type'];

      if (type == PropertyType.apartment) {
        property = Apartment(
          id: propertyId,
          ownerId: _ownerId,
          images: [],
          createdAt: DateTime.now(),
          // Map common fields
          title: formData['title'],
          description: formData['description'],
          price: formData['price'],
          location: formData['location'],
          bedrooms: formData['bedrooms'],
          bathrooms: formData['bathrooms'],
          bhk: formData['bhk'],
          area: formData['area'],
          isAvailable: formData['isAvailable'],
          amenities: formData['amenities'],
          // Map apartment-specific fields
          floor: formData['floor'],
          apartmentNumber: formData['apartmentNumber'],
          hasElevator: formData['hasElevator'],
          hasSecurity: formData['hasSecurity'],
          hasParking: formData['hasParking'],
          hasBalcony: formData['hasBalcony'],
        );
      } else {
        property = HousesModel(
          id: propertyId,
          ownerId: _ownerId,
          images: [],
          createdAt: DateTime.now(),
          // Map common fields
          title: formData['title'],
          description: formData['description'],
          price: formData['price'],
          location: formData['location'],
          bedrooms: formData['bedrooms'],
          bathrooms: formData['bathrooms'],
          bhk: formData['bhk'],
          area: formData['area'],
          isAvailable: formData['isAvailable'],
          amenities: formData['amenities'],
          // Map house-specific fields
          floors: formData['floors'],
          landArea: formData['landArea'],
          hasGarden: formData['hasGarden'],
          hasPool: formData['hasPool'],
          isFurnished: formData['isFurnished'],
        );
      }

      // 3. Save the property to the repository
      await _propertyRepository.addProperty(property);
      success = true;

    } catch (e) {
      onError(e.toString());
    } finally {
      state = false; // Stop loading
    }
    return success;
  }
}
