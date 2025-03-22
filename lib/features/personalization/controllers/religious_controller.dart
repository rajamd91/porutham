import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poruththam_app/data/repositories/profile/religious_repository.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';
import '../models/religious_model.dart';

class ReligiousController extends GetxController {
  static ReligiousController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<ReligiousDetailModel> religious = ReligiousDetailModel.empty().obs;

  /// Variables
  final deviceStorage = GetStorage();
  final religion = TextEditingController();
  var madhab = 'Shafi'.obs;
  var division = 'Ravuthar'.obs;
  final jamath = TextEditingController();
  var follows = 'SunnathJamath'.obs;
  var religiousValues = 'StrictlyFollows'.obs;
  final docId = TextEditingController();
  GlobalKey<FormState> religiousDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  RxBool refreshData = true.obs;
  final religiousDetailsRepository = Get.put(ReligiousDetailsRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;

  final List<String> madhabList = [
    'Shafi',
    'Hanafi',
    'Maliki',
    'Hanbali',
  ];

  final List<String> divisionList = [
    'Ravuthar',
    'Methar',
    'Pattani',
    'Seyadu',
    'Maraikayar',
    'Tamil Shafi',
    'Others',
  ];

  final List<String> followsList = [
    'SunnathJamath',
    'Tawhid',
    'Jaqh',
    'Mujahid',
    'Sufis',
    'Others',
  ];

  final List<String> religiousValuesList = [
    'StrictlyFollows',
    'Namaz Five Times',
    'Namaz Only Friday',
    'Namaz Only Yearly',
    'Average Muslim',
    'Occasionally',
    'Not Given It A Thought',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchReligiousRecord();
  }

  void updateMadhab(String? newValue) {
    if (newValue != null) {
      madhab.value = newValue;
    }
  }

  void updateDivision(String? newValue) {
    if (newValue != null) {
      division.value = newValue;
    }
  }

  void updateFollows(String? newValue) {
    if (newValue != null) {
      follows.value = newValue;
    }
  }

  void updateReligiousValues(String? newValue) {
    if (newValue != null) {
      religiousValues.value = newValue;
    }
  }

  Future<void> fetchReligiousRecord() async {
    try {
      profileLoading.value = true;
      final religious =
          await religiousDetailsRepository.fetchReligiousDetails();
      this.religious(religious);
    } catch (e) {
      religious(ReligiousDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getReligiousData() {
    const docId = "ReligiousDetail";
    return religiousDetailsRepository.getReligiousDetail('ReligiousDetail');
  }

  Future addNewReligiousDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing religious Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!religiousDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final religiousDetail = ReligiousDetailModel(
        id: '',
        religion: religion.text.trim(),
        madhab: madhab.value.trim(),
        division: division.value.trim(),
        jamath: jamath.text.trim(),
        follows: follows.value.trim(),
        religiousValues: religiousValues.value.trim(),
        docId: 'ReligiousDetail',
      );

      final id =
          await religiousDetailsRepository.addReligiousDetail(religiousDetail);

      deviceStorage.writeIfNull('IsReligiousDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh ReligiousDetails data
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

  Future addNewReligiousDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing religious Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!religiousDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final religiousDetail = ReligiousDetailModel(
        id: '',
        religion: religion.text.trim(),
        madhab: madhab.value.trim(),
        division: division.value.trim(),
        jamath: jamath.text.trim(),
        follows: follows.value.trim(),
        religiousValues: religiousValues.value.trim(),
        docId: 'BioData',
      );

      final id = await religiousDetailsRepository
          .addReligiousDetailToUserCollection(religiousDetail);

      deviceStorage.writeIfNull('IsReligiousDetailsUpdated', true);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh ReligiousDetails data
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
    religion.clear();
    madhab.close();
    division.close();
    jamath.clear();
    follows.close();
    religiousValues.close();
    religiousDetailsFormKey.currentState!.reset();
  }
}
