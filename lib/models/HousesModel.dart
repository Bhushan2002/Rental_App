import 'package:rental_application/models/PropertyModel.dart';

class HousesModel extends Property{
  final int floors;
  final bool hasGarden;
  final bool hasPool;
  final double landArea;
  final bool isFurnished;

  HousesModel({
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
    required this.floors,
    required this.hasGarden,
    required this.hasPool,
    required this.landArea,
    required this.isFurnished,
}):super(
    id:id,
    type: PropertyType.house,
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
      'floors': floors,
      'hasGarden': hasGarden,
      'landArea': landArea,
      'hasPool': hasPool,
      'isFurnished': isFurnished,
    };
  }

  factory HousesModel.fromMap(Map<String, dynamic> map) {
    return HousesModel(
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
      floors: map['floors']?.toInt() ?? 1,
      hasGarden: map['hasGarden'] ?? false,
      landArea: map['landArea']?.toDouble() ?? 0.0,
      hasPool: map['hasPool'] ?? false,
      isFurnished: map['isFurnished'] ?? false, bhk: map['bhk'] ?? 0,
    );
  }
  @override
  String toString() {
    return 'House(${super.toString()}, floors: $floors, landArea: $landArea)';
  }

}