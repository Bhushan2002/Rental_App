import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/property_controller.dart';

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
    final ow_properties = ref.watch(myPropertiesProvider);
    print(ow_properties);

    return Scaffold(
      body: ow_properties.when(
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
              return InkWell(
                child: PropertyCard(
                  title: property.title,
                  imageUrl: property.images[0],
                  price: property.price,
                  address: property.location,
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
