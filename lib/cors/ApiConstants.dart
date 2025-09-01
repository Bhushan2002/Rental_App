class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:9000/';

  static const String createProperty =
      'http://10.0.2.2:9000/properties/createproperty';
  static String updateProperty(String id) =>
      'http://10.0.2.2:9000/properties/$id';
  static String deleteProperty(String id) =>
      'http://10.0.2.2:9000/properties/$id';

  static const String ownerProperties =
      'http://10.0.2.2:9000/properties/ownerproperties';
}
