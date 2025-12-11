import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/data/PropertyData/property_controller.dart';

import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/widgets/PropertyCard.dart';

class Ownerproperties extends ConsumerStatefulWidget {
  const Ownerproperties({super.key});

  @override
  ConsumerState createState() => _OwnerpropertiesState();
}

class _OwnerpropertiesState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final owProperties = ref.watch(myPropertiesProvider);
    print(owProperties);

    return Scaffold(
      body: owProperties.when(
        data: (properties) {
          if (properties.isEmpty) {
            return const Center(
              child: Text("You haven't created any properties yet."),
            );
          }
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              final address = '${property.street}, ${property.city}';
              return InkWell(
                child: PropertyCard(
                  title: property.title,
                  imageUrl: property.images.isNotEmpty
                      ? property.images[0]
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcCBHgbS23kyBw2r8Pquu19UtKZnrZmFUx1g&s",
                  price: property.price,
                  address: address,
                  baths: property.bathrooms,
                  beds: property.bedrooms,
                  bhk: property.bhk,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdatePropertyPage(property: property),
                    ),
                  );
                },
              );
            },
          );
        },
        error: (err, st) =>
            Text(err.toString(), style: TextStyle(color: Colors.red)),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
