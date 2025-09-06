import 'package:rental_application/models/PropertyModel.dart';

class Apartment extends Property {
  final int floor;
  final bool hasElevator;
  final bool hasSecurity;
  final String apartmentNumber;
  final bool hasParking;
  final bool hasBalcony;

  Apartment({
    required String id,
    required String title,
    required String description,
    required double price,
    required String street,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required List<String> images,
    required int bathrooms,
    required int bedrooms,
    required double area,
    required int bhk,
    required DateTime createdAt,
    required bool isAvailable,
    required String ownerId,
    required List<String> amenities,
    Coordinates? coordinates,
    required this.floor,
    required this.hasElevator,
    required this.hasSecurity,
    required this.apartmentNumber,
    required this.hasParking,
    required this.hasBalcony,
  }) : super(
         id: id,
         type: PropertyType.Apartment,
         title: title,
         description: description,
         price: price,
         street: street,
         city: city,
         state: state,
         country: country,
         postalCode: postalCode,
         coordinates: coordinates,
         images: images,
         bedrooms: bedrooms,
         bathrooms: bathrooms,
         bhk: bhk,
         area: area,
         isAvailable: isAvailable,
         createdAt: createdAt,
         ownerId: ownerId,
         amenities: amenities,
       );

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'floor': floor,
      'hasElevator': hasElevator,
      'hasSecurity': hasSecurity,
      'apartmentNumber': apartmentNumber,
      'hasParking': hasParking,
      'hasBalcony': hasBalcony,
    };
  }

  factory Apartment.fromMap(Map<String, dynamic> map) {
    return Apartment(
      id: (map['_id'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      price: (map['price'] ?? 0).toDouble(),
      street: (map['street'] ?? '').toString(),
      city: (map['city'] ?? '').toString(),
      state: (map['state'] ?? '').toString(),
      country: (map['country'] ?? '').toString(),
      postalCode: (map['postalCode'] ?? '').toString(),
      images: (map['images'] != null)
          ? List<String>.from(map['images'])
          : <String>[],
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      area: (map['area'] ?? 0).toDouble(),
      isAvailable: map['isAvailable'] ?? true,
      createdAt: (map['createdAt'] != null)
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      ownerId: (map['ownerId'] ?? '').toString(),
      amenities: (map['amenities'] != null)
          ? List<String>.from(map['amenities'])
          : <String>[],
      coordinates: map['coordinates'] != null
          ? Coordinates.fromMap(map['coordinates'])
          : null,
      floor: map['floor'] ?? 0,
      hasElevator: map['hasElevator'] ?? false,
      hasSecurity: map['hasSecurity'] ?? false,
      apartmentNumber: (map['apartmentNumber'] ?? '').toString(),
      hasParking: map['hasParking'] ?? false,
      hasBalcony: map['hasBalcony'] ?? false,
      bhk: map['bhk'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Apartment(${super.toString()}, floor: $floor, apartmentNumber: $apartmentNumber)';
  }
}
