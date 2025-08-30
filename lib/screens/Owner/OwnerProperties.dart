import 'dart:math';

import 'package:flutter/material.dart';

class Ownerproperties extends StatefulWidget {
  const Ownerproperties({super.key});

  @override
  State<Ownerproperties> createState() => _OwnerpropertiesState();
}

class _OwnerpropertiesState extends State<Ownerproperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        height: 258,
        width: double.infinity,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // image and price
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                    height: 199,
                    width: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          scale: sqrt1_2,
                          'https://images.unsplash.com/photo-1723110994499-df46435aa4b3?q=80&w=2079&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Divider(height: 1),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 6,
                    horizontal: 3,
                  ),
                  child: Text(
                    '₹ 20,000',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Card(
              child: Container(
                width: 200,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Property Title ',
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 1,
                      right: 0,
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.favorite_border),
                          Icon(Icons.share),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
