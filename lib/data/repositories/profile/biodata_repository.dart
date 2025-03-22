import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';

import '../authentication/authentication_repository.dart';

class BioDataRepository extends GetxController {
  static BioDataRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<BioDataModel> fetchBioDataDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return BioDataModel.fromSnapshot(documentSnapshot);
      } else {
        return BioDataModel.empty();
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
}
