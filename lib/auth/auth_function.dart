import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUri = "http://10.0.2.2:9000/";

Future<void> loginUser(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUri/login'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('Sign-In successful');
      print('Token ${responseBody['token']}');
    } else {
      final errorBody = jsonDecode((response.body));
      print('Failed to sign in: ${errorBody['message']}');
    }
  } catch (e) {
    print('An error occurred: $e');
    // Handle network errors, etc.
  }
}
