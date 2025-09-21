import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/auth/auth_provider.dart';

import 'package:rental_application/cors/ApiConstants.dart';
import 'package:rental_application/models/PropertyModel.dart';
import 'package:rental_application/models/UserModel.dart';
import 'package:rental_application/screens/MainScreens/HomScreen.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyForm.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/widgets/MapWidget.dart';

class UpdatePropertyPage extends ConsumerStatefulWidget {
  final Property property;
  const UpdatePropertyPage({super.key, required this.property});

  @override
  ConsumerState<UpdatePropertyPage> createState() => _UpdatePropertyPageState();
}

class _UpdatePropertyPageState extends ConsumerState<UpdatePropertyPage> {
  // Replace with your Mapbox access token
  final String mapboxAccessToken = ApiConstants.MAPBOXKEY;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    final textTheme = Theme.of(context).primaryTextTheme;
    final role = ref.watch(userDetailsProvider).value ?? UserRole.tenant;
    // print(widget.property.coordinates);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property.title),
        actions: [
          (role == 'owner'
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            UpdatePropertyForm(property: widget.property),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                )
              : Container()),
          (role == 'owner'
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).cardColor,
                          title: Text(
                            "Are you sure you want to delete this property?",
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          content: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                            ),
                            child: Text('Delete'),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                )
              : Container()),

          themeButton(ref),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: widget.property.images.length,
              itemBuilder: (BuildContext context, index, pageIndex) {
                return Container(
                  height: 200,
                  width: 400,
                  color: Colors.black,
                  child: Image.network(
                    widget.property.images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg',
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                );
              },
              options: CarouselOptions(
                height: 300,

                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                // scrollDirection: Axis.vertical,
              ),
            ),
            SizedBox(height: 10),
            Divider(height: 5, thickness: 2),
            const SizedBox(height: 20),
            Text(
              widget.property.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.property.street}, ${widget.property.city}',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.9),
            Text(
              'Price',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "₹ ${widget.property.price.toStringAsFixed(0)}/month",
              style: textTheme.bodyLarge,
            ),

            SizedBox(height: 10),
            Divider(thickness: 0.9),
            Text(
              "Description",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.property.description, style: textTheme.bodyMedium),
            SizedBox(height: 10),
            Divider(thickness: 0.9),

            Text(
              'Details',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(
                  context,
                  icon: Icons.bed_outlined,
                  label: 'Bedrooms',
                  value: widget.property.bedrooms.toString(),
                ),
                _buildDetailItem(
                  context,
                  icon: Icons.bathtub_outlined,
                  label: 'Bathrooms',
                  value: widget.property.bathrooms.toString(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(
                  context,
                  icon: Icons.home_outlined,
                  label: 'BHK',
                  value: widget.property.bhk.toString(),
                ),
                _buildDetailItem(
                  context,
                  icon: Icons.area_chart_outlined,
                  label: 'Area',
                  value: '${widget.property.area} sqft',
                ),
              ],
            ),
            SizedBox(height: 10),

            // You can add more details here if needed
            // e.g., Furnishing Status, Parking, etc.
            // _buildDetailItem(context, icon: Icons.chair_outlined, label: 'Furnishing', value: widget.property.furnishingStatus ?? "N/A"),
            // _buildDetailItem(context, icon: Icons.local_parking_outlined, label: 'Parking', value: widget.property.parkingAvailable ? "Available" : "Not Available"),
            Divider(thickness: 0.9),
            Text(
              "Amenities",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.property.amenities.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.property.amenities[index],
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.9),
            Text(
              'Location',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Container(
              height: 300,
              child: MapboxWidget(
                latitude: widget.property.coordinates!.lat,
                longitute: widget.property.coordinates!.lon,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final textTheme = Theme.of(context).primaryTextTheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 5),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
