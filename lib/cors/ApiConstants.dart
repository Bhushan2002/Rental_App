class ApiConstants {
  static const String MAPBOXKEY =
      "pk.eyJ1IjoiYmh1c2hhbjAwMiIsImEiOiJjbTg0ZG0xaHIwZzQ3Mm1xM25ydGFlN3AxIn0.5WRzjQkRduSj-QiglG28MA";

  static const String baseUrl = 'http://10.0.2.2:9000/';

  static const String createProperty =
      'http://10.0.2.2:9000/properties/createproperty';
  static String updateProperty(String id) =>
      'http://10.0.2.2:9000/properties/$id';
  static String deleteProperty(String id) =>
      'http://10.0.2.2:9000/properties/$id';

  static const String allProperties =
      'http://10.0.2.2:9000/properties/all-properties';
  static String propertyByCity(String city) =>
      'http://10.0.2.2:9000/properties/$city/';

  static const String ownerProperties =
      'http://10.0.2.2:9000/properties/ownerproperties';
}
