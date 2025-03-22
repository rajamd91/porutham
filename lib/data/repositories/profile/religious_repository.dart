import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poruththam_app/features/personalization/models/basic_detail_model.dart';
import 'package:poruththam_app/features/personalization/models/locationDetailModel.dart';

import '../../../features/personalization/models/religious_model.dart';
import '../../../utils/helpers/loader.dart';
import '../authentication/authentication_repository.dart';

class ReligiousDetailsRepository extends GetxController {
  static ReligiousDetailsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ReligiousDetailModel> fetchReligiousDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return ReligiousDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return ReligiousDetailModel.empty();
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

  Future<List<ReligiousDetailModel>> fetchUserReligiousDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('BioData').get();

      return result.docs
          .map((documentSnapshot) =>
              ReligiousDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching religious information.Try again later';
    }
  }

  /// Get single record
  Future<ReligiousDetailModel> getReligiousDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final religiousData =
        snapshot.docs.map((e) => ReligiousDetailModel.fromSnapshot(e)).single;
    return religiousData;
  }

  /// Get All Users Records
  Future<List<ReligiousDetailModel>> getAllUsersReligiousDetails(
      String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot =
        await _db.collection('Users').doc(userId).collection('BioData').get();

    final religiousData =
        snapshot.docs.map((e) => ReligiousDetailModel.fromSnapshot(e)).toList();
    return religiousData;
  }

  Future<String> addReligiousDetail(
      ReligiousDetailModel religiousDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentReligiousDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('ReligiousDetails')
          .set(religiousDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the address information.Try again Later';
    }
  }

  Future<String> addReligiousDetailToUserCollection(
      ReligiousDetailModel religiousDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentReligiousDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(religiousDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the address information.Try again Later';
    }
  }
}
