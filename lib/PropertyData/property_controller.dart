import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/Property_repository.dart';
import 'package:rental_application/models/PropertyModel.dart';

// The StateNotifierProvider for the controller
final propertyControllerProvider =
    StateNotifierProvider<PropertyController, bool>(
      (ref) => PropertyController(
        propertyRepository: ref.watch(propertyRepositoryProvider),
      ),
    );

class PropertyController extends StateNotifier<bool> {
  final PropertyRepository _propertyRepository;

  PropertyController({required PropertyRepository propertyRepository})
    : _propertyRepository = propertyRepository,
      super(false); // Initial state is 'false' (not loading)

  Future<bool> addProperty({
    required Map<String, dynamic> formData,
    required void Function(String error) onError,
  }) async {
    state = true; // Set loading state to true
    try {
      await _propertyRepository.addProperty(formData: formData);
      state = false; // Set loading state back to false
      return true; // Return true on success
    } catch (e) {
      onError(
        e.toString().replaceAll('Exception: ', ''),
      ); // Execute the error callback with a clean messages
      state = false; // Set loading state back to false
      return false; // Return false on failure
    }
  }

  /// Updates an existing property using its ID.
  Future<bool> updateProperty({
    required String id,
    required Map<String, dynamic> formData,
    required void Function(String error) onError,
  }) async {
    state = true;
    try {
      await _propertyRepository.updateProperty(id: id, formData: formData);
      state = false;
      return true;
    } catch (e) {
      onError(e.toString().replaceAll('Exception: ', ''));
      state = false;
      return false;
    }
  }

  /// Deletes a property using its ID.
  Future<bool> deleteProperty({
    required String id,
    required void Function(String error) onError,
  }) async {
    state = true;
    try {
      await _propertyRepository.deleteProperty(id: id);
      state = false;

      return true;
    } catch (e) {
      onError(e.toString().replaceAll('Exception: ', ''));
      state = false;
      return false;
    }
  }
}

final myPropertiesProvider = FutureProvider<List<Property>>((ref) {
  final propertyRepository = ref.watch(propertyRepositoryProvider);
  return propertyRepository.getMyProperties();
});
