import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/personalization/models/physical_detail_model.dart';
import '../authentication/authentication_repository.dart';

class PhysicalDetailsRepository extends GetxController {
  static PhysicalDetailsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<PhysicalDetailModel> fetchPhysicalDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return PhysicalDetailModel.fromSnapshot(documentSnapshot);
      } else {
        return PhysicalDetailModel.empty();
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

  Future<List<PhysicalDetailModel>> fetchUserPhysicalDetails() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information.Try again in few minutes';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('BioData').get();

      return result.docs
          .map((documentSnapshot) =>
              PhysicalDetailModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching location information.Try again later';
    }
  }

  /// Get single record
  Future<PhysicalDetailModel> getPhysicalDetail(String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: docId)
        .get();

    final physicalData =
        snapshot.docs.map((e) => PhysicalDetailModel.fromSnapshot(e)).single;
    return physicalData;
  }

  /// Get All Users Records
  Future<List<PhysicalDetailModel>> getAllUsersPhysicalDetails(
      String docId) async {
    final userId = AuthenticationRepository.instance.authUser!.uid;

    final snapshot =
        await _db.collection('Users').doc(userId).collection('BioData').get();

    final physicalData =
        snapshot.docs.map((e) => PhysicalDetailModel.fromSnapshot(e)).toList();
    return physicalData;
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
      throw 'Unable to update your basic details.Try Again latter';
    }
  }

  Future<String> addPhysicalDetail(PhysicalDetailModel physicalDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentPhysicalDetail = await _db
          .collection('Users')
          .doc(userId)
          .collection('BioData')
          .doc('PhysicalDetails')
          .set(physicalDetail.toJson());
      //.add(physicalDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the physical detail information.Try again Later';
    }
  }

  Future<String> addPhysicalDetailToUserCollection(
      PhysicalDetailModel physicalDetail) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentPhysicalDetail = await _db
          .collection('Users')
          .doc(userId)
          .update(physicalDetail.toJson());
      //.add(physicalDetail.toJson());
      return "";
    } catch (e) {
      throw 'Something went wrong while saving the physical detail information.Try again Later';
    }
  }
}
