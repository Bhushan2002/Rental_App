import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/screens/auth/SignInPage.dart';

import 'package:rental_application/widgets/InputFields.dart';

// The main sign-in page widget
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  // State variable to toggle password visibility
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  void _signup() {
    if (_isLoading) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    ref
        .read(authControllerProvider.notifier)
        .signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
          ),
        );
    if (mounted) {
      Navigator.of(context).pop();
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> _signup() async {
  //   if (_isLoading) return;
  //   if (_passwordController.text != _confirmPasswordController.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Passwords do not match'),
  //         backgroundColor: Colors.redAccent,
  //       ),
  //     );
  //     return;
  //   }
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     if(mounted){
  //       Navigator.of(context).pop();
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String message;
  //     if (e.code == 'weak-password') {
  //       message = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       message = 'An account already exists for that email.';
  //     } else {
  //       message = 'An error occurred. Please try again.';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
  //     );
  //   }finally {
  //     if (mounted) {
  //       setState(() { _isLoading = false; });
  //     }
  //   }
  // }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              buildHeader('welcome'),
              const SizedBox(height: 48.0),

              buildfirstAndLastNameField(
                _firstNameController,
                _lastNameController,
              ),
              const SizedBox(height: 16.0),

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

              _buildConfirmPasswordField(),
              const SizedBox(height: 16.0),

              // Forgot Password Link
              buildForgotPasswordLink(),
              const SizedBox(height: 24.0),

              // Sign In Button
              buildSignInButton('Sign Up', () => {_signup()}),
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
                      // TODO: Navigate to the sign-up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
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

  // Widget for the password text field
  Widget buildPasswordField() {
    return TextField(
      // Toggles secure text entry based on the state variable
      obscureText: !_isPasswordVisible,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[200],
        // Suffix icon to toggle password visibility
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            // Update the state to change the icon and visibility
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextField(
      controller: _confirmPasswordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
