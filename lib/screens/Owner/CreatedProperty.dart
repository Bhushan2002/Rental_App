import 'package:flutter/material.dart';

class CreatedProperty extends StatefulWidget {
  const CreatedProperty({super.key});

  @override
  State<CreatedProperty> createState() => _CreatedPropertyState();
}

class _CreatedPropertyState extends State<CreatedProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Properties")));
  }
}
