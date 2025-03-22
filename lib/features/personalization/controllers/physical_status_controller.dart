import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poruththam_app/features/personalization/models/basic_detail_model.dart';
import 'package:poruththam_app/features/personalization/models/physical_detail_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/profile/physical_detail_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';

class PhysicalDetailController extends GetxController {
  static PhysicalDetailController get instance => Get.find();

  //final _auth = FirebaseAuth.instance;

  /// Variables
  final deviceStorage = GetStorage();
  final physicalStatus = 'Normal'.obs;
  final height = '4 ft 0 in / 122 cm'.obs;
  final weight = 40.obs;
  final color = 'Wheatish'.obs;
  final bodyType = 'Fit'.obs;
  GlobalKey<FormState> physicalDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  final profileLoading = false.obs;
  RxBool refreshData = true.obs;
  final physicalDetailsRepository = Get.put(PhysicalDetailsRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;
  final _db = FirebaseFirestore.instance;
  final _physicalRepo = Get.put(PhysicalDetailsRepository());
  final Rx<PhysicalDetailModel> physical = PhysicalDetailModel.empty().obs;

  final List<String> physicalStatusList = [
    'Normal',
    'Physically Challenged',
  ];

  final List<String> heightList = [
    '4 ft 0 in / 122 cm',
    '4 ft 1 in / 124 cm',
    '4 ft 2 in / 127 cm',
    '4 ft 3 in / 130 cm',
    '4 ft 4 in / 132 cm',
    '4 ft 5 in / 135 cm',
    '4 ft 6 in / 137 cm',
    '4 ft 7 in / 140 cm',
    '4 ft 8 in / 142 cm',
    '4 ft 9 in / 145 cm',
    '4 ft 10 in / 147 cm',
    '4 ft 11 in / 150 cm',
    '5 ft 0 in / 152 cm',
    '5 ft 1 in / 155 cm',
    '5 ft 2 in / 157 cm',
    '5 ft 3 in / 160 cm',
    '5 ft 4 in / 163 cm',
    '5 ft 5 in / 165 cm',
    '5 ft 6 in / 168 cm',
    '5 ft 7 in / 170 cm',
    '5 ft 8 in / 173 cm',
    '5 ft 9 in / 175 cm',
    '5 ft 10 in / 178 cm',
    '5 ft 11 in / 180 cm',
    '6 ft 0 in / 183 cm',
    '6 ft 1 in / 185 cm',
    '6 ft 2 in / 188 cm',
    '6 ft 3 in / 191 cm',
    '6 ft 4 in / 193 cm',
    '6 ft 5 in / 196 cm',
    '6 ft 6 in / 198 cm',
    '6 ft 7 in / 201 cm',
    '6 ft 8 in / 203 cm',
    '6 ft 9 in / 206 cm',
    '6 ft 10 in / 208 cm',
    '6 ft 11 in / 211 cm',
    '7 ft 0 in / 213 cm',
  ];

  final List<int> weightList = List.generate(101, (index) => 40 + index);

  final List<String> colorList = ['Wheatish', 'Whitish', 'Black'];
  final List<String> bodyTypeList = ['Fit', 'Slim', 'Obese', 'Skinny'];

  @override
  void onInit() {
    super.onInit();
    fetchPhysicalRecord();
  }

  void updatePhysicalStatus(String? newValue) {
    if (newValue != null) {
      physicalStatus.value = newValue;
    }
  }

  void updateHeight(String? newValue) {
    if (newValue != null) {
      height.value = newValue;
    }
  }

  void updateWeight(int? newValue) {
    if (newValue != null) {
      weight.value = newValue;
    }
  }

  void updateColor(String? newValue) {
    if (newValue != null) {
      color.value = newValue;
    }
  }

  void updateBodyType(String? newValue) {
    if (newValue != null) {
      bodyType.value = newValue;
    }
  }

  Future<void> fetchPhysicalRecord() async {
    try {
      profileLoading.value = true;
      final physical = await physicalDetailsRepository.fetchPhysicalDetails();
      this.physical(physical);
    } catch (e) {
      physical(PhysicalDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getPhysicalData() {
    const docId = "PhysicalDetail";
    return _physicalRepo.getPhysicalDetail('PhysicalDetail');
  }

  Future addNewPhysicalDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Physical Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!physicalDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save Physical Details Data
      final physicalDetail = PhysicalDetailModel(
        id: '',
        physicalStatus: physicalStatus.value.trim(),
        height: height.value.trim(),
        weight: weight.value.toString(),
        color: color.value.trim(),
        bodyType: bodyType.value.trim(),
        docId: 'PhysicalDetail',
      );

      final id =
          await physicalDetailsRepository.addPhysicalDetail(physicalDetail);
      deviceStorage.writeIfNull('IsPhysicalDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh BasicDetails data
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

  Future addNewPhysicalDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Physical Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!physicalDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save Physical Details Data
      final physicalDetail = PhysicalDetailModel(
        id: '',
        physicalStatus: physicalStatus.value.trim(),
        height: height.value.trim(),
        weight: weight.value.toString(),
        color: color.value.trim(),
        bodyType: bodyType.value.trim(),
        docId: 'BioData',
      );

      final id = await physicalDetailsRepository
          .addPhysicalDetailToUserCollection(physicalDetail);

      deviceStorage.writeIfNull('IsPhysicalDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh BasicDetails data
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
    //physicalStatus.clear();
    height.close();
    weight.close();
    color.close();
    bodyType.close();
    physicalDetailsFormKey.currentState!.reset();
  }
}
