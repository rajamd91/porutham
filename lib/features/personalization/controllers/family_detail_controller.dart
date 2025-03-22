import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/profile/family_detail_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';
import '../models/family_details_model.dart';

class FamilyController extends GetxController {
  static FamilyController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<FamilyDetailModel> family = FamilyDetailModel.empty().obs;

  /// Variables
  final deviceStorage = GetStorage();
  var familyType = 'Nuclear Family'.obs;
  var familyStatus = 'Middle Class'.obs;
  final fatherOccupation = TextEditingController();
  final motherOccupation = TextEditingController();
  final familyOrigin = TextEditingController();
  var noOfBrothers = 0.obs;
  var brothersMarried = 0.obs;
  var noOfSisters = 0.obs;
  var sistersMarried = 0.obs;

  GlobalKey<FormState> familyDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  RxBool refreshData = true.obs;
  final familyDetailsRepository = Get.put(FamilyDetailsRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;
  final _db = FirebaseFirestore.instance;
  final _familyRepo = Get.put(FamilyDetailsRepository());

  final List<String> familyTypeList = [
    'Nuclear Family',
    'Joint Family',
  ];

  final List<String> familyStatusList = [
    'Middle Class',
    'Upper Middle Class',
    'Rich/Affluent',
    'Elite',
  ];

  List<String> siblingRanges = [];
  List<String> marriedSiblingRanges = [];

  @override
  void onInit() {
    super.onInit();
    fetchFamilyRecord();
  }

  void setSelectedBrothersValue(int value) {
    noOfBrothers.value = value;
    brothersMarried.value = 0;
  }

  void setSelectedMarriedBrothersValue(int value) {
    brothersMarried.value = value;
  }

  void setSelectedSistersValue(int value) {
    noOfSisters.value = value;
    sistersMarried.value = 0;
  }

  void setSelectedMarriedSistersValue(int value) {
    sistersMarried.value = value;
  }

  void updateFamilyType(String? newValue) {
    if (newValue != null) {
      familyType.value = newValue;
    }
  }

  void updateFamilyStatus(String? newValue) {
    if (newValue != null) {
      familyStatus.value = newValue;
    }
  }

  Future<void> fetchFamilyRecord() async {
    try {
      profileLoading.value = true;
      final family = await familyDetailsRepository.fetchFamilyDetails();
      this.family(family);
    } catch (e) {
      family(FamilyDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getFamilyData() {
    const docId = "FamilyDetail";
    return _familyRepo.getFamilyDetail('FamilyDetail');
  }

  Future addNewFamilyDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Family Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!familyDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final familyDetail = FamilyDetailModel(
        id: '',
        familyType: familyType.value.trim(),
        familyStatus: familyStatus.value.trim(),
        fatherOccupation: fatherOccupation.text.trim(),
        motherOccupation: motherOccupation.text.trim(),
        familyOrigin: familyOrigin.text.trim(),
        noOfBrothers: noOfBrothers.value.toString(),
        brothersMarried: brothersMarried.value.toString(),
        noOfSisters: noOfSisters.value.toString(),
        sistersMarried: sistersMarried.value.toString(),
        docId: 'FamilyDetail',
      );

      final id = await familyDetailsRepository.addFamilyDetail(familyDetail);

      deviceStorage.writeIfNull('IsFamilyDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh Family Details data
      refreshData.toggle();

      /// Reset Fields
      resetFormFields();

      /// Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Details Not Found', message: e.toString());
    }
  }

  Future addNewFamilyDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Family Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!familyDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final familyDetail = FamilyDetailModel(
        id: '',
        familyType: familyType.value.trim(),
        familyStatus: familyStatus.value.trim(),
        fatherOccupation: fatherOccupation.text.trim(),
        motherOccupation: motherOccupation.text.trim(),
        familyOrigin: familyOrigin.text.trim(),
        noOfBrothers: noOfBrothers.value.toString(),
        brothersMarried: brothersMarried.value.toString(),
        noOfSisters: noOfSisters.value.toString(),
        sistersMarried: sistersMarried.value.toString(),
        docId: 'BioData',
      );

      final id = await familyDetailsRepository
          .addFamilyDetailToUserCollection(familyDetail);

      deviceStorage.writeIfNull('IsFamilyDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh Family Details data
      refreshData.toggle();

      /// Reset Fields
      resetFormFields();

      /// Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Details Not Found', message: e.toString());
    }
  }

  /// Function to Reset Form Fields
  void resetFormFields() {
    familyType.close();
    familyStatus.close();
    fatherOccupation.clear();
    motherOccupation.clear();
    familyOrigin.clear();
    noOfBrothers.close();
    brothersMarried.close();
    noOfSisters.close();
    sistersMarried.close();
    familyDetailsFormKey.currentState!.reset();
  }
}
