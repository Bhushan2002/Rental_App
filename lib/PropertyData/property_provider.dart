import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/Property_repository.dart';
import 'package:rental_application/PropertyData/property_controller.dart';
import 'package:rental_application/auth/auth_provider.dart';
import 'package:rental_application/models/PropertyModel.dart';

final firebaseStorageProvider = Provider((_) => FirebaseStorage.instance);

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  return PropertyRepository(
    firestore: ref.watch(fireStoreProvider),
    storage: ref.watch(firebaseStorageProvider),
  );
});

final propertyControllerProvider =
    StateNotifierProvider<PropertyController, bool>((ref) {
      return PropertyController(
        propertyRepository: ref.watch(propertyRepositoryProvider),
        ownerId: ref.watch(authStateChangesProvide).value?.uid,
      );
    });

/// A stream provider that fetches all properties from Firestore in real-time.
/// The UI will listen to this to display an up-to-date list of properties.
final allPropertiesProvider = StreamProvider<List<Property>>((ref) {
  return ref.watch(propertyRepositoryProvider).getProperties();
});
