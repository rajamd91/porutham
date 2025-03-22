//import 'dart:html';
//import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../../features/shop/models/category_model.dart';
import '../../../utils/firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// variables
  final _db = FirebaseFirestore.instance;

  /// Get All Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapShot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// Get Sub Categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapShot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      ///upload all the categories along with their images
      final storage = Get.put(TFirebaseStorageService());

      /// Loop through each category
      for (var category in categories) {
        /// Get imageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        /// Upload image and get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        /// Assign URL to Category image attribute
        category.image = url;

        /// Store category in Firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      // throw TFirebaseException
      throw e.code;
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }
}
