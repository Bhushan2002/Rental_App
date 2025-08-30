import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_function.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/models/UserModel.dart';
import 'package:rental_application/screens/auth/signupPage.dart';
import 'package:http/http.dart' as http;
import 'package:rental_application/widgets/InputFields.dart';

// The main sign-in page widget
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> loginUser() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUri/login'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
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

  void _signIn() {
    ref
        .read(authControllerProvider.notifier)
        .signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: UserRole.tenant,
          onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
          ),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a SingleChildScrollView to prevent overflow when the keyboard appears
      body: Center(
        child: Padding(
          // Adding padding around the main content
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Header Section
              buildHeader(context, 'Welcome Back!'),
              Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
              const SizedBox(height: 48.0),

              // Email Input Field
              inputField(
                'Email',
                const Icon(Icons.email_outlined),
                _emailController,
              ),
              const SizedBox(height: 16.0),

              // Password Input Field
              buildPasswordField(),
              const SizedBox(height: 16.0),

              // Forgot Password Link
              buildForgotPasswordLink(),
              const SizedBox(height: 24.0),

              // Sign In Button
              buildSignInButton('Sign In', () => _signIn()),
              const SizedBox(height: 24.0),

              // Social Login Divider
              buildSocialLoginDivider(),
              const SizedBox(height: 24.0),

              // Social Login Buttons
              buildSocialLoginButtons(),
              const SizedBox(height: 32.0),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextField(
      obscureText: !_isPasswordVisible,
      controller: _passwordController,
      style: TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black54),
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[300],

        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
