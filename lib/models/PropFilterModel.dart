class PropertyFilter {
  final int? bhk;
  final int? minPrice;
  final int? maxPrice;
  final bool? isFurnished;
  final String? propertyType;

  PropertyFilter({
    this.bhk,
    this.minPrice,
    this.maxPrice,
    this.isFurnished,
    this.propertyType,
  });

  PropertyFilter copyWith({
    int? bhk,
    int? minPrice,
    int? maxPrice,
    bool? isFurnished,
    String? propertyType,
  }) {
    return PropertyFilter(
      bhk: bhk ?? this.bhk,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isFurnished: isFurnished ?? this.isFurnished,
      propertyType: propertyType ?? this.propertyType,
    );
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (bhk != null) params['bhk'] = bhk.toString();
    if (minPrice != null) params['minPrice'] = minPrice.toString();
    if (maxPrice != null) params['maxPrice'] = maxPrice.toString();
    if (isFurnished != null) params['isFurnished'] = isFurnished.toString();
    if (propertyType != null) params['propertyType'] = propertyType!;

    return params;
  }
}
