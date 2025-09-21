import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/theme/themeProvider.dart';

class FullMap extends ConsumerStatefulWidget {
  const FullMap({super.key});

  @override
  ConsumerState<FullMap> createState() => _FullMapState();
}

class _FullMapState extends ConsumerState<FullMap> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Full Map View")),
      body: MapWidget(
        key: const ValueKey("fullMapWidget"),
        androidHostingMode: AndroidPlatformViewHostingMode.TLHC_HC,
        cameraOptions: CameraOptions(
          zoom: 15,
          center: Point(coordinates: Position(73.8567, 18.5204)),
        ),
        styleUri: themeMode == ThemeMode.dark
            ? 'mapbox://styles/bhushan002/cmeqx95kk002y01sf7p5h1p55'
            : "mapbox://styles/bhushan002/cmeqxdzsb009401qt4tgrds1z",
        onMapCreated: (mapboxMap) {
          // You can add additional map setup here if needed
        },
      ),
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    // Create annotation manager
    final annotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();
    _pointAnnotationManager = annotationManager;

    // Load marker image (from assets)
    final ByteData bytes = await rootBundle.load(
      "assets/images/pin.png",
    ); // <- add your pin icon in assets
    final Uint8List markerImage = bytes.buffer.asUint8List();

    // Create annotation options
    var options = PointAnnotationOptions(
      geometry: Point(coordinates: Position(18.412, 17.215)),
      image: markerImage,
      iconSize: 0.5, // adjust size if needed
    );

    // Add annotation (marker)
    await annotationManager.create(options);
  }
}
