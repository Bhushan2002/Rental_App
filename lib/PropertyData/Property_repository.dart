import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rental_application/cors/ApiConstants.dart';

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
}
