import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rental_application/models/PropertyModel.dart';
import 'package:uuid/uuid.dart';

class PropertyRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  PropertyRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  }) : _firestore = firestore,
       _storage = storage;
  CollectionReference get _properties => _firestore.collection('properties');

  Future<List<String>> uploadImages(List<File> images, String propertyId)async{
    List<String> imageUrls = [];
    for (var image in images){
      final ref = _storage.ref().child('property_images').child(propertyId).child(const Uuid().v4());
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    return imageUrls;
  }
  
  
  Future<void> addProperty(Property property) async {
    try {
      await _properties.doc(property.id).set(property.toMap());
    } on FirebaseException catch (e) {
      throw Exception("Error adding property: ${e.message}");
    }
  }

  // Fetch properties

  Stream<List<Property>> getProperties() {
    return _properties.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Property.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}


//update property

Future<void> updateProperty(Property property) async{}

// delete property

Future<void> deleteProperty (Property property)async {}