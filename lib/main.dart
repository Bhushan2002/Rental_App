import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:rental_application/auth/auth_provider.dart';

import 'package:rental_application/screens/Owner/LandingPage.dart';

import 'package:rental_application/screens/auth/SignInPage.dart';
import 'package:rental_application/theme/themeProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> setup() async {
  MapboxOptions.setAccessToken(
    "pk.eyJ1IjoiYmh1c2hhbjAwMiIsImEiOiJjbTg0ZG0xaHIwZzQ3Mm1xM25ydGFlN3AxIn0.5WRzjQkRduSj-QiglG28MA",
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvide);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: authState.when(
        data: (user) {
          if (user != null) {
            return LandingPage();
          }
          return SignInPage();
        },
        error: (err, stack) =>
            Scaffold(body: Center(child: Text("error: $err"))),
        loading: () =>
            const Scaffold(body: Center(child: Text('there is a problem'))),
      ),
    );
  }
}
