import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/profession_model.dart';
import '../authentication/authentication_repository.dart';

class ProfessionRepository extends GetxController {
  static ProfessionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ProfessionDetailModel> fetchProfessionDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return ProfessionDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return ProfessionDetailModel.empty();
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

  Future<ProfessionDetailModel> getProfessionDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final professionData =
        snapshot.docs.map((e) => ProfessionDetailModel.fromSnapshot(e)).single;
    return professionData;
  }

  Future<List<ProfessionDetailModel>> fetchUserProfessionDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('ProfessionDetails')
          .get();

      return result.docs
          .map((documentSnapshot) =>
              ProfessionDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Profession information.Try again later';
    }
  }

  Future<ProfessionDetailModel> fetchSingleProfessionDetail() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('ProfessionDetails')
          .get();

      return result.docs
          .map((documentSnapshot) =>
              ProfessionDetailModel.fromDocumentSnapshot(documentSnapshot))
          .single;
    } catch (e) {
      throw 'Something went wrong while fetching Professional information.Try again later';
    }
  }

  Future<void> updateSelectedField(
      String professionDetailId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('ProfessionDetails')
          .doc(professionDetailId)
          .update({'SelectedProfessionDetails': selected});
    } catch (e) {
      throw 'Unable to update your Profession details.Try Again latter';
    }
  }

  Future<String> addProfessionDetail(
      ProfessionDetailModel professionDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentProfessionDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('ProfessionDetails')
          .set(professionDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Professional information.Try again Later';
    }
  }

  Future<String> addProfessionDetailToUserCollection(
      ProfessionDetailModel professionDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentProfessionDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(professionDetail.toJson());
      //.add(basicDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the Professional information.Try again Later';
    }
  }
}
