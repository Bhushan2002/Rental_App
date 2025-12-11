import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/data/PropertyData/property_controller.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/widgets/PropertyCard.dart';

class PropertyList extends ConsumerStatefulWidget {
  const PropertyList({super.key});

  @override
  ConsumerState<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends ConsumerState<PropertyList> {
  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(getAllPropertiesProvider);
    final userDetails = ref.watch(userDetailsProvider);

    return userDetails.when(
      data: (user) {
        if (user == null) {
          return Text("User data not found.");
        }
        return properties.when(
          data: (property) {
            if (property.isEmpty) {
              return Center(child: Text("No properties available"));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: property.length,
              itemBuilder: (context, index) {
                final prop = property[index];
                final address = '${prop.street}, ${prop.city}';
                return InkWell(
                  child: PropertyCard(
                    title: prop.title,
                    imageUrl: prop.images.isNotEmpty
                        ? prop.images[0]
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcCBHgbS23kyBw2r8Pquu19UtKZnrZmFUx1g&s",
                    price: prop.price,
                    address: address,
                    baths: prop.bathrooms,
                    beds: prop.bedrooms,
                    bhk: prop.bhk,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdatePropertyPage(property: prop),
                      ),
                    );
                  },
                );
              },
            );
          },
          error: (err, stk) => Text('Error: $err'),
          loading: () => Center(child: CircularProgressIndicator()),
        );
      },
      error: (err, stack) => Text('$err'),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
