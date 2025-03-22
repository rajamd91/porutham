import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poruththam_app/features/personalization/models/locationDetailModel.dart';

import '../authentication/authentication_repository.dart';

class LocationDetailsRepository extends GetxController {
  static LocationDetailsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<LocationDetailModel> fetchLocationDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return LocationDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return LocationDetailModel.empty();
      }
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

  Future<List<LocationDetailModel>> fetchUserLocationDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('LocationDetails')
          .get();

      return result.docs
          .map((documentSnapshot) =>
              LocationDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching location information.Try again later';
    }
  }

  /// Get single record
  Future<LocationDetailModel> getLocationDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final locationData =
        snapshot.docs.map((e) => LocationDetailModel.fromSnapshot(e)).single;
    return locationData;
  }

  /// Get All Users Records
  Future<List<LocationDetailModel>> getAllUsersLocationDetails(
      String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot =
        await _db.collection('Users').doc(userId).collection('BioData').get();

    final locationData =
        snapshot.docs.map((e) => LocationDetailModel.fromSnapshot(e)).toList();
    return locationData;
  }

  Future<String> addLocationDetail(LocationDetailModel locationDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentLocationDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('LocationDetails')
          .set(locationDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the address information.Try again Later';
    }
  }

  Future<String> addLocationDetailToUserCollection(
      LocationDetailModel locationDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentLocationDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(locationDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the address information.Try again Later';
    }
  }
}
