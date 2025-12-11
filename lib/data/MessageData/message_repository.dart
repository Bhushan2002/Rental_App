import 'dart:convert';

import 'package:rental_application/cors/ApiConstants.dart';
import 'package:http/http.dart' as http;

class MessageRepository {
  Future<void> sendMessage({
    required String ownerId,
    required String tenantId,
    required String tenantName,
    required String tenantEmail,
    required String message,
    required String propertyId,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/message/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'ownerId': ownerId,
        'tenantId': tenantId,
        'tenantName': tenantName,
        'tenantEmail': tenantEmail,
        'message': message,
        'propertyId': propertyId,
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }
}
