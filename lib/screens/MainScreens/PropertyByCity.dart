import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/data/PropertyData/property_controller.dart';
import 'package:rental_application/models/PropFilterModel.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/widgets/PropertyCard.dart';
import 'package:rental_application/widgets/propertyFilter.dart';

class PropertyByCity extends ConsumerStatefulWidget {
  final String city;
  const PropertyByCity({super.key, required this.city});

  @override
  ConsumerState<PropertyByCity> createState() => _PropertyByCityState();
}

class _PropertyByCityState extends ConsumerState<PropertyByCity> {
  @override
  Widget build(BuildContext context) {
    final List<String> filterList = ['BHK', 'Furnished', 'Parking', 'Parking'];
    final List<String> selectedFilter = [];

    final properties = ref.watch(propertiesByCityProvider(widget.city));
    PropertyFilter? activeFilter;
    void applyFilter() {

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Properties in ${widget.city}'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: PropertyFilterWidget(
                      onApply: (filter) {
                        setState(() {
                          activeFilter = filter;
                        });
                        applyFilter();
                      },
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.sort, size: 28),
          ),
        ],
      ),
      body: properties.when(
        data: (property) {
          if (property.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(parent: ScrollPhysics()),
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
          } else {
            return Center(child: Text('No properties found in ${widget.city}'));
          }
        },
        error: (err, stk) => Text("$err"),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
