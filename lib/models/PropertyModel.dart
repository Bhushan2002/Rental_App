
enum PropertyType { apartment, house }

enum FurnishedType { fullyFurnished, semiFurnished, unfurnished }

class Property {
  final String id;
  final PropertyType type;
  final String title;
  final String description;
  final double price;
  final String location;
  final List<String>? images;
  final int bedrooms;
  final int bathrooms;
  final int bhk;
  final double area;
  final bool isAvailable;
  final DateTime createdAt;
  final String ownerId;
  final List<String> amenities;
  final DateTime? updatedAt;

  Property({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.bhk,
    required this.isAvailable,
    required this.createdAt,
    required this.ownerId,
    required this.amenities,
    this.updatedAt,
  });

  Property copyWith({
    String? id,
    PropertyType? type,
    String? title,
    String? description,
    double? price,
    String? location,
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
  }) {
    return Property(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toString(),
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'images': images,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'isAvailable': isAvailable,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'ownerId': ownerId,
      'amenities': amenities,

      'updatedAt': updatedAt,
      'bhk': bhk,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'],
      type: PropertyType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => PropertyType.apartment,
      ),
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

      updatedAt: map['updatedAt'],
      bhk: map['bhk']
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
