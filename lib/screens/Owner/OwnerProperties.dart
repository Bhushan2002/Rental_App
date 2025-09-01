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
      body: ListView(
        children: [
          propertyCard(),
          propertyCard(),
          propertyCard(),
          propertyCard(),
        ],
      ),
    );
  }

  Widget propertyCard() {
    return Card(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            height: 224,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // image and price
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),

                        image: DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1723110994499-df46435aa4b3?q=80&w=2079&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 215,
                        height: 70,
                        child: Text(
                          'Property Title ',
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 45),
                      Divider(height: 1, color: Colors.black),
                      SizedBox(
                        width: 218,
                        height: 40,
                        child: Text(
                          "Address:a hsd lapdjaspdjasd adj  jpaosjd dlak ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, size: 30),
                  onPressed: () {},
                ),

                IconButton(icon: Icon(Icons.share, size: 30), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
