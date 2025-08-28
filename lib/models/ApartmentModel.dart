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
    required String location,
    required List<String> images,
    required int bathrooms,
    required int bedrooms,
    required double area,
    required int bhk,
    required DateTime createdAt,
    required bool isAvailable,
    required String ownerId,
    required List<String> amenities,

    required this.floor,
    required this.hasElevator,
    required this.hasSecurity,
    required this.apartmentNumber,
    required this.hasParking,
    required this.hasBalcony,

  }) : super(
    id: id,
    type: PropertyType.apartment,
    title: title,
    description: description,
    price: price,
    location: location,
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
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price']?.toDouble() ?? 0.0,
      location: map['location'],
      images: List<String>.from(map['images']),
      bedrooms: map['bedrooms']?.toInt() ?? 0,
      bathrooms: map['bathrooms']?.toInt() ?? 0,
      area: map['area']?.toDouble() ?? 0.0,
      isAvailable: map['isAvailable'] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      ownerId: map['ownerId'],
      amenities: List<String>.from(map['amenities']),
      floor: map['floor']?.toInt() ?? 0,
      hasElevator: map['hasElevator'] ?? false,
      hasSecurity: map['hasSecurity'] ?? false,
      apartmentNumber: map['apartmentNumber'] ?? '',
      hasParking: map['hasParking'] ?? false,
      hasBalcony: map['hasBalcony'] ?? false, bhk: map['bhk'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Apartment(${super.toString()}, floor: $floor, apartmentNumber: $apartmentNumber)';
  }
}