import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/models/basic_detail_model.dart';

import '../../../features/personalization/models/profession_model.dart';
import '../authentication/authentication_repository.dart';

class BasicDetailRepository extends GetxController {
  static BasicDetailRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<BasicDetailModel> fetchBasicDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return BasicDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return BasicDetailModel.empty();
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

  Future<BasicDetailModel> getBasicDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final basicData =
        snapshot.docs.map((e) => BasicDetailModel.fromSnapshot(e)).single;
    return basicData;
  }

  Future<List<BasicDetailModel>> fetchUserBasicDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('BioData').get();

      return result.docs
          .map((documentSnapshot) =>
              BasicDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Basic Detail information.Try again later';
    }
  }

  Future<BasicDetailModel> fetchSingleBasicDetail() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('BioData').get();
      final basicB = result.docs
          .map((documentSnapshot) =>
              BasicDetailModel.fromDocumentSnapshot(documentSnapshot))
          .single;

      return basicB;
    } catch (e) {
      throw 'Something went wrong while fetching Basic Detail information.Try again later';
    }
  }

  Future<void> updateSelectedField(String basicDetailId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc(basicDetailId)
          .update({'SelectedBasicDetails': selected});
    } catch (e) {
      throw 'Unable to update your Basic details.Try Again latter';
    }
  }

  Future<String> addBasicDetail(BasicDetailModel basicDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentBasicDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('BasicDetails')
          .set(basicDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Basic Detail information.Try again Later';
    }
  }

  Future<String> addBasicDetailToUserCollection(
      BasicDetailModel basicDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentBasicDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(basicDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Basic Detail information.Try again Later';
    }
  }
}
