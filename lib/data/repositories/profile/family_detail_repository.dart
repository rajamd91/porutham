import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/personalization/models/family_details_model.dart';
import '../authentication/authentication_repository.dart';

class FamilyDetailsRepository extends GetxController {
  static FamilyDetailsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<FamilyDetailModel> fetchFamilyDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return FamilyDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return FamilyDetailModel.empty();
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

  Future<List<FamilyDetailModel>> fetchUserFamilyDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('BioData').get();

      return result.docs
          .map((documentSnapshot) =>
              FamilyDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Family information.Try again later';
    }
  }

  /// Get single record
  Future<FamilyDetailModel> getFamilyDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final familyData =
        snapshot.docs.map((e) => FamilyDetailModel.fromSnapshot(e)).single;
    return familyData;
  }

  /// Get All Users Records
  Future<List<FamilyDetailModel>> getAllUsersFamilyDetails(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot =
        await _db.collection('Users').doc(userId).collection('BioData').get();

    final familyData =
        snapshot.docs.map((e) => FamilyDetailModel.fromSnapshot(e)).toList();
    return familyData;
  }

  // Future<void> updateSelectedField(String basicDetailId, bool selected) async {
  //   try {
  //     final userId = AuthenticationRepository.instance.authUser!.uid;
  //     await _db
  //         .collection('Users')
  //         .doc(userId)
  //         .collection('BioData')
  //         .doc(basicDetailId)
  //         .update({'SelectedBasicDetails': selected});
  //   } catch (e) {
  //     throw 'Unable to update your basic details.Try Again latter';
  //   }
  // }

  Future<String> addFamilyDetail(FamilyDetailModel familyDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentFamilyDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('FamilyDetail')
          .set(familyDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Family Detail information.Try again Later';
    }
  }

  Future<String> addFamilyDetailToUserCollection(
      FamilyDetailModel familyDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentFamilyDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(familyDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Family Detail information.Try again Later';
    }
  }
}
