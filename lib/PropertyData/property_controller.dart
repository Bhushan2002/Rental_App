import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/PropertyData/Property_repository.dart';

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

  /// A future function to add a property, mirroring the structure of your `_submitForm`.
  ///
  /// The [formData] map contains all the property details, including a list of image files.
  /// The [onError] callback is executed if an exception occurs during the process.
  /// Returns a `Future<bool>` indicating success or failure.
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
}
