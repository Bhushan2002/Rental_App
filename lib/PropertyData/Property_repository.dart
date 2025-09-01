import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rental_application/cors/ApiConstants.dart';
import 'package:rental_application/models/PropertyModel.dart';

// Provider to create an instance of the repository
final propertyRepositoryProvider = Provider((ref) => PropertyRepository());

class PropertyRepository {
  /// Adds a new property by sending a multipart request to the backend.
  ///
  /// Throws an [Exception] with an error message on failure.
  Future<void> addProperty({required Map<String, dynamic> formData}) async {
    try {
      // Get the current user's Firebase ID token for authentication
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated. Please log in.');
      }
      final token = await user.getIdToken();

      // Create a multipart request for uploading files
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.createProperty),
      );

      // Add the authentication token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields from the form data
      formData.forEach((key, value) {
        if (key != 'images' && value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Add image files to the request
      final List<File> imageFiles = formData['images'] as List<File>;
      for (final imageFile in imageFiles) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images', // This key must match what your backend (e.g., multer) expects
            imageFile.path,
          ),
        );
      }

      // Send the request
      final streamedResponse = await request.send();

      // Check the response
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 201) {
        // If the server did not return a 201 CREATED response, throw an error.
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ?? 'Failed to add property. Please try again.',
        );
      }
    } catch (e) {
      // Re-throw any caught exception to be handled by the controller
      throw Exception(e.toString());
    }
  }

  Future<void> updateProperty({
    required String id,
    required Map<String, dynamic> formData,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated. Please log in.');
      }
      final token = await user.getIdToken();

      final request = http.MultipartRequest(
        'PUT', // Use PUT for updating resources
        Uri.parse(ApiConstants.updateProperty(id)),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      formData.forEach((key, value) {
        if (key != 'images' && value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Add any new image files if they exist
      if (formData.containsKey('images')) {
        final List<File> imageFiles = formData['images'] as List<File>;
        for (final imageFile in imageFiles) {
          request.files.add(
            await http.MultipartFile.fromPath('images', imageFile.path),
          );
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // A successful update usually returns a 200 OK status
      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to update property.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Deletes a property using its ID.
  Future<void> deleteProperty({required String id}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated. Please log in.');
      }
      final token = await user.getIdToken();

      final response = await http.delete(
        Uri.parse(ApiConstants.deleteProperty(id)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      // A successful deletion usually returns a 200 OK status
      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to delete property.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Property>> getMyProperties() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated.');
      }
      final token = await user.getIdToken();

      final response = await http.get(
        Uri.parse(ApiConstants.ownerProperties),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];

        return responseData
            .map<Property>((json) => Property.fromJson(json))
            .toList();
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to fetch properties.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
