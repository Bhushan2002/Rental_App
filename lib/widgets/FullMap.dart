import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/models/PropertyModel.dart';
import 'package:rental_application/screens/Owner/UpdatePropertyPage.dart';
import 'package:rental_application/theme/themeProvider.dart';
import 'package:rental_application/PropertyData/property_controller.dart';

class _MyPointAnnotationClickListener
    implements OnPointAnnotationClickListener {
  final Function(PointAnnotation) onAnnotationClicked;

  _MyPointAnnotationClickListener(this.onAnnotationClicked);

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onAnnotationClicked(annotation);
  }
}

class FullMap extends ConsumerStatefulWidget {
  const FullMap({super.key});

  @override
  ConsumerState createState() => _FullMapState();
}

class _FullMapState extends ConsumerState<FullMap> {
  Property? _selectedProperty;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);
    final propertiesAsyncValue = ref.watch(getAllPropertiesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Properties on Map')),
      body: propertiesAsyncValue.when(
        data: (properties) {
          return Stack(
            children: [
              MapWidget(
                key: const ValueKey("mapWidget"),
                androidHostingMode: AndroidPlatformViewHostingMode.TLHC_HC,
                cameraOptions: CameraOptions(
                  zoom: 12,
                  center: Point(
                    coordinates: Position(
                      73.8567, // Default to Pune
                      18.5204,
                    ),
                  ),
                ),
                styleUri: themeMode == ThemeMode.dark
                    ? 'mapbox://styles/bhushan002/cmeqx95kk002y01sf7p5h1p55'
                    : "mapbox://styles/bhushan002/cmeqxdzsb009401qt4tgrds1z",
                onMapCreated: (mapboxMap) =>
                    _onMapCreated(mapboxMap, properties),
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search location',
                      filled: true,
                      fillColor: themeMode == ThemeMode.dark
                          ? Colors.black54
                          : Colors.white54,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (value) {
                      [
                            "pune",
                            "mumbai",
                            "bangalore",
                          ].contains(value.toLowerCase())
                          ? MapWidget(
                              cameraOptions: CameraOptions(
                                center: Point(
                                  coordinates: Position(
                                    value.toLowerCase() == "pune"
                                        ? 73.8567
                                        : value.toLowerCase() == "mumbai"
                                        ? 72.8777
                                        : 77.5946,
                                    value.toLowerCase() == "pune"
                                        ? 18.5204
                                        : value.toLowerCase() == "mumbai"
                                        ? 19.0760
                                        : 12.9716,
                                  ),
                                ),
                                zoom: 12,
                              ),
                            )
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Location not found')),
                            );
                    },
                  ),
                ),
              ),
              if (_selectedProperty != null)
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              UpdatePropertyPage(property: _selectedProperty!),
                        ),
                      );
                    },
                    child: Card(
                      color: themeMode == ThemeMode.dark
                          ? Colors.black45
                          : Colors.white38,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedProperty!.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹ ${_selectedProperty!.price}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "${_selectedProperty!.street}, ${_selectedProperty!.city}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _onMapCreated(
    MapboxMap mapboxMap,
    List<Property> properties,
  ) async {
    final pointAnnotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();

    final ByteData bytes = await rootBundle.load("assets/images/pin.png");
    final Uint8List markerImage = bytes.buffer.asUint8List();

    final List<PointAnnotationOptions> options = [];
    for (final property in properties) {
      if (property.coordinates != null) {
        options.add(
          PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                property.coordinates!.lon,
                property.coordinates!.lat,
              ),
            ),
            image: markerImage,
            iconSize: 0.5,
          ),
        );
      }
    }

    final annotations = await pointAnnotationManager.createMulti(options);

    // Create an instance of our listener and pass it to the manager
    pointAnnotationManager.addOnPointAnnotationClickListener(
      _MyPointAnnotationClickListener((clickedAnnotation) {
        for (var i = 0; i < annotations.length; i++) {
          if (annotations[i]?.id == clickedAnnotation.id) {
            setState(() {
              _selectedProperty = properties[i];
            });
            break;
          }
        }
      }),
    );
  }
}
