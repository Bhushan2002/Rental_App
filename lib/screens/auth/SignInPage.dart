import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/screens/auth/signupPage.dart';

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

  // Future<void> _signIn() async {
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );
  //     print('sign in successfully/');
  //   } on FirebaseAuthException catch (e) {
  //     String message;
  //     if (e.code =='user-not-found'){
  //       message = "no user found that email.";
  //     }else if (e.code == 'wrong-password') {
  //       message = 'Wrong password provided for that user.';
  //     } else {
  //       message = 'An error occurred. Please try again.';
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         backgroundColor: Colors.redAccent,
  //       ),
  //     );
  //   }
  // }

  void _signIn() {
    ref
        .read(authControllerProvider.notifier)
        .signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
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
              buildHeader('Welcome Back!'),
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
                      // TODO: Navigate to the sign-up page
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
}
