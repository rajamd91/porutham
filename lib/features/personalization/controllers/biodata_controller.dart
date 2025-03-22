import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';

import '../../../data/repositories/profile/biodata_repository.dart';

class BioDataController extends GetxController {
  static BioDataController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final profileLoading = false.obs;
  Rx<BioDataModel> bioData = BioDataModel.empty().obs;
  final bioDataRepository = Get.put(BioDataRepository());

  @override
  void onInit() {
    super.onInit();
    fetchBioDataRecord();
  }

  Future<void> fetchBioDataRecord() async {
    try {
      profileLoading.value = true;
      final bioData = await bioDataRepository.fetchBioDataDetails();
      this.bioData(bioData);
    } catch (e) {
      bioData(BioDataModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  bool basicHasEmptyFields() {
    return bioData.value.name.isEmpty == true ||
        bioData.value.gender.isEmpty == true ||
        bioData.value.birthDate.isEmpty == true ||
        bioData.value.motherTongue.isEmpty == true ||
        bioData.value.maritalStatus.isEmpty == true ||
        bioData.value.profileCreater.isEmpty == true;
  }

  bool physicalHasEmptyFields() {
    return bioData.value.physicalStatus.isEmpty == true ||
        bioData.value.height.isEmpty == true ||
        bioData.value.weight.isEmpty == true ||
        bioData.value.color.isEmpty == true ||
        bioData.value.bodyType.isEmpty == true;
  }

  bool professionHasEmptyFields() {
    return bioData.value.education.isEmpty == true ||
        bioData.value.educationDetail.isEmpty == true ||
        bioData.value.employedIn.isEmpty == true ||
        bioData.value.occupation.isEmpty == true ||
        bioData.value.occupationDetail.isEmpty == true ||
        bioData.value.income.isEmpty == true;
  }

  bool familyHasEmptyFields() {
    return bioData.value.familyType.isEmpty == true ||
        bioData.value.familyStatus.isEmpty == true ||
        bioData.value.fatherOccupation.isEmpty == true ||
        bioData.value.motherOccupation.isEmpty == true ||
        bioData.value.familyOrigin.isEmpty == true ||
        bioData.value.noOfBrothers.isEmpty == true ||
        bioData.value.brothersMarried.isEmpty == true ||
        bioData.value.noOfSisters.isEmpty == true ||
        bioData.value.sistersMarried.isEmpty == true;
  }

  bool religiousHasEmptyFields() {
    return bioData.value.religion.isEmpty == true ||
        bioData.value.madhab.isEmpty == true ||
        bioData.value.division.isEmpty == true ||
        bioData.value.jamath.isEmpty == true ||
        bioData.value.follows.isEmpty == true ||
        bioData.value.religiousValues.isEmpty == true;
  }

  bool locationHasEmptyFields() {
    return bioData.value.country.isEmpty == true ||
        bioData.value.state.isEmpty == true ||
        bioData.value.district.isEmpty == true ||
        bioData.value.city.isEmpty == true ||
        bioData.value.address.isEmpty == true ||
        bioData.value.pincode.isEmpty == true;
  }
}
