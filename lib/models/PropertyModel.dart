class Coordinates {
  final double lat;
  final double lon;

  Coordinates({required this.lat, required this.lon});

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lon': lon};
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: (map['lat'] ?? 0.0).toDouble(),
      lon: (map['lon'] ?? 0.0).toDouble(),
    );
  }
}

enum PropertyType { Apartment, House }

enum FurnishedType { fullyFurnished, semiFurnished, unfurnished }

class Property {
  final String id;
  final PropertyType type;
  final String title;
  final String description;
  final double price;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final int bhk;
  final double area;
  final bool isAvailable;
  final DateTime createdAt;
  final String ownerId;
  final List<String> amenities;
  final DateTime? updatedAt;
  final Coordinates? coordinates;

  Property({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.bhk,
    required this.isAvailable,
    required this.createdAt,
    required this.ownerId,
    required this.amenities,
    this.updatedAt,
    this.coordinates,
  });

  Property copyWith({
    String? id,
    PropertyType? type,
    String? title,
    String? description,
    double? price,
    String? street,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    List<String>? images,
    int? bedrooms,
    int? bathrooms,
    double? area,
    bool? isAvailable,
    String? ownerId,
    List<String>? amenities,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? bhk,
    Coordinates? coordinates,
  }) {
    return Property(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      images: images ?? this.images,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      area: area ?? this.area,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      ownerId: ownerId ?? this.ownerId,
      amenities: amenities ?? this.amenities,
      updatedAt: updatedAt ?? this.updatedAt,
      bhk: bhk ?? this.bhk,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString(),
      'title': title,
      'description': description,
      'price': price,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'images': images,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'isAvailable': isAvailable,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'ownerId': ownerId,
      'amenities': amenities,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'bhk': bhk,
      'coordinates': coordinates?.toMap(),
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: (json['_id'] ?? '').toString(),
      type: PropertyType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type']?.toString(),
        orElse: () => PropertyType.Apartment,
      ),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: (json['price'] ?? 0).toDouble(),
      street: (json['street'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      state: (json['state'] ?? '').toString(),
      country: (json['country'] ?? '').toString(),
      postalCode: (json['postalCode'] ?? '').toString(),
      images: (json['images'] != null)
          ? List<String>.from(json['images'])
          : <String>[],
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      bhk: json['bhk'] ?? 0,
      area: (json['area'] ?? 0).toDouble(),
      isAvailable: json['isAvailable'] ?? true,
      createdAt: (json['createdAt'] != null)
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      ownerId: (json['ownerId'] ?? '').toString(),
      amenities: (json['amenities'] != null)
          ? List<String>.from(json['amenities'])
          : <String>[],
      updatedAt: (json['updatedAt'] != null)
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      coordinates: json['coordinates'] != null
          ? Coordinates.fromMap(json['coordinates'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Property(id: $id, type: $type, title: $title, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Property && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
