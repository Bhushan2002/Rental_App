import 'package:flutter/material.dart';

Widget buildfirstAndLastNameField(
  TextEditingController firstnameController,
  TextEditingController lastNameController,
) {
  return Row(
    children: [
      Expanded(child: inputField('First Name', null, firstnameController)),
      const SizedBox(width: 16.0), // Add spacing between the fields
      Expanded(child: inputField('Last Name', null, lastNameController)),
    ],
  );
}

Widget inputField(String text, Icon? icon, TextEditingController? controller) {
  return TextField(
    // Toggles secure text entry based on the state variable
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: icon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      filled: true,
      fillColor: Colors.grey[200],
    ),
  );
}

// Widget for the header section
Widget buildHeader(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        'Sign in to continue',
        style: TextStyle(fontSize: 18.0, color: Colors.grey),
      ),
    ],
  );
}

// Widget for the "Forgot Password?" link
Widget buildForgotPasswordLink() {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        // TODO: Implement forgot password functionality
        print('Forgot Password Tapped');
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blueAccent),
      ),
    ),
  );
}

// Widget for the main sign-in button
Widget buildSignInButton(String text, Function signIn) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    onPressed: () {
      signIn();
    },
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Widget for the divider with "Or sign in with" text
Widget buildSocialLoginDivider() {
  return const Row(
    children: <Widget>[
      Expanded(child: Divider(color: Colors.grey)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('Or sign in with', style: TextStyle(color: Colors.grey)),
      ),
      Expanded(child: Divider(color: Colors.grey)),
    ],
  );
}

// Widget for the social media login buttons (Google, Apple)
Widget buildSocialLoginButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // Google Sign-In Button
      socialButton(
        'assets/images/Google.png', // Placeholder, replace with your asset
        onTap: () {
          print('Google Sign-In Tapped');
        },
      ),
      const SizedBox(width: 20),
      // Apple Sign-In Button
      socialButton(
        'assets/images/Facebook.png', // Placeholder, replace with your asset
        isApple: true,
        onTap: () {
          // TODO: Implement Apple sign-in
          print('Meta Sign-In Tapped');
        },
      ),
    ],
  );
}

// Helper widget to create a social button
Widget socialButton(
  String assetPath, {
  bool isApple = false,
  required VoidCallback onTap,
}) {
  // This is a placeholder for an image. In a real app, you would add image assets.
  // For now, we'll use icons as placeholders.
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade700, width: 1),
      ),
      child: Icon(
        isApple ? Icons.apple : Icons.android, // Placeholder icons
        color: Colors.white,
        size: 30,
      ),
    ),
  );
}
