import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:poruththam_app/data/repositories/profile/basic_detail_repository.dart';
import 'package:poruththam_app/features/personalization/models/basic_detail_model.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';

class BasicDetailController extends GetxController {
  static BasicDetailController get instance => Get.find();

  final deviceStorage = GetStorage();
  final profileLoading = false.obs;
  Rx<BasicDetailModel> basic = BasicDetailModel.empty().obs;

  /// Variables
  var name = ''.obs;
  //var name = TextEditingController().obs;
  // final gender = TextEditingController();
  var birthDate = ''.obs;
  var eligibleYear = 0.obs;
  //final motherTongue = TextEditingController();
  var maritalStatus = 'UnMarried'.obs;
  var profileCreater = 'Father'.obs;
  GlobalKey<FormState> basicDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  RxBool refreshData = true.obs;
  var status = '';
  final basicDetailsRepository = Get.put(BasicDetailRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;
  final _db = FirebaseFirestore.instance;

  // Observable variable for the selected language
  var motherTongue = 'Tamil'.obs;

  // List of languages for the dropdown
  final List<String> languageList = [
    'Tamil',
    'Malayalam',
    'Kannada',
    'Telugu',
    'Urdu',
    'Hindi',
    'Others',
  ];

  // Observable variable for the selected Marital Status
  //var selectedMaritalStatus = 'UnMarried'.obs;

  // List of Status for the dropdown
  final List<String> maritalStatusList = [
    'UnMarried',
    'Married',
    'Divorce',
    'Widow/Widower',
    'Separated',
  ];

  // Observable variable for the Profile Creater
  //var profiler = 'Father'.obs;

  // List of Status for the dropdown
  final List<String> profilerList = [
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Grand Parent',
    'Relative',
    'Friend',
  ];

  @override
  void onInit() {
    fetchBasicRecord();
    fetchUserName();
    hasEmptyFields();
    super.onInit();
  }

  void hasEmptyFields() {
    if (name?.isEmpty == true ||
        gender?.isEmpty == true ||
        birthDate?.isEmpty == true ||
        motherTongue?.isEmpty == true ||
        maritalStatus?.isEmpty == true ||
        profileCreater?.isEmpty == true) {
      status = 'yes';
    }
  }

  /// Fetch the particular field value from Firestore collection of the current user
  void fetchUserName() async {
    try {
      DocumentSnapshot userDoc =
          await _db.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        name.value = userDoc['Username'];
        //fieldValue.value = 'Raja Mohamed';
        // print('RAJA');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error fetching field value: $e', message: e.toString());
    }
  }

  // Method to update the selected language
  void updateLanguage(String? newValue) {
    if (newValue != null) {
      motherTongue.value = newValue;
    }
  }

  void updateMaritalStatus(String? newValue) {
    if (newValue != null) {
      maritalStatus.value = newValue;
    }
  }

  void setDateOfBirth(String date) {
    birthDate.value = date;
  }

  void updateProfiler(String? newValue) {
    if (newValue != null) {
      profileCreater.value = newValue;
    }
  }

  // Observable variable for selected period
  var gender = "".obs; // Default value
  List<String> genderList = ["Male", "Female"];

// Method to update the selected period
  void updateSelectedGender(String value) {
    gender.value = value;
    if (gender.value == 'Male') {
      eligibleYear.value = 21;
    } else if (gender.value == 'Female') {
      eligibleYear.value = 18;
    }
    //gender=selectedGender.value;
  }

  Future<void> selectDate(BuildContext context) async {
    var date = DateTime(DateTime.now().year - eligibleYear.value,
        DateTime.now().month, DateTime.now().day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: date,
    );
    if (picked != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      birthDate(formattedDate);
    }
  }

  Future<void> fetchBasicRecord() async {
    try {
      profileLoading.value = true;
      final basic = await basicDetailsRepository.fetchBasicDetails();
      this.basic(basic);
    } catch (e) {
      basic(BasicDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getBasicDetailData() {
    const docId = "BasicDetail";
    return basicDetailsRepository.getBasicDetail("BasicDetail");
  }

  // Future<BasicDetailModel> sGetData() async {
  //   final ttt = await _db
  //       .collection('Users')
  //       .doc(userId)
  //       .collection('BioData')
  //       .doc('BasicDetail')
  //       //.where("docId", isEqualTo: "BasicDetail")
  //       .get();
  //
  //   // var bbb = ttt.data();
  //   // final result =
  //   //     await _db.collection('Users').doc(userId).collection('BioData').get();
  //   // var sss = await result.collection('BioData').doc('BasicDetails').get();
  //   // final basicDetail = ttt.docs
  //   //     .map((documentSnapshot) =>
  //   //         BasicDetailModel.fromDocumentSnapshot(documentSnapshot))
  //   //     //.toList()
  //   //     .single;
  //   final basicDetail = BasicDetailModel.fromDocumentSnapshot(ttt);
  //
  //   return basicDetail;
  //   // return ttt;
  // }

  Future<BasicDetailModel> getData() async {
    final ttt = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: "BasicDetail")
        .get();

    //var bbb = ttt.data();
    // final result =
    //     await _db.collection('Users').doc(userId).collection('BioData').get();
    //var sss = await result.collection('BioData').doc('BasicDetails').get();
    final basicDetail = ttt.docs
        .map((ttt) => BasicDetailModel.fromDocumentSnapshot(ttt))
        .single;
    return basicDetail;
    // final result =
    //     await _db.collection('Users').doc(userId).collection('BioData').get();
    // final professionDetail = result.docs
    //     .map((documentSnapshot) =>
    //         ProfessionDetailModel.fromDocumentSnapshot(documentSnapshot))
    //     .single;
    // return professionDetail;
  }

  Future<List<BasicDetailModel>> getAllUserBasicDetails() async {
    try {
      final basicDetails = await basicDetailsRepository.fetchUserBasicDetails();
      // selectedAddress.value = addresses.firstWhere(
      //         (element) => element.selectedAddress,
      //     orElse: () => AddressModel.empty());
      return basicDetails;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Basic Details not found', message: e.toString());
      return [];
    }
  }

  getSingleBasicDetails() async {
    try {
      final basicDetails =
          await basicDetailsRepository.fetchSingleBasicDetail();

      return basicDetails;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Basic Detail Not Found', message: e.toString());
      return [];
    }
  }

  Future addNewBasicDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Basic Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!basicDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save Basic Detail Data
      final basicDetail = BasicDetailModel(
        id: '',
        name: name.value.trim(),
        gender: gender.value.trim(),
        birthDate: birthDate.value.trim(),
        motherTongue: motherTongue.value.trim(),
        maritalStatus: maritalStatus.value.trim(),
        profileCreater: profileCreater.value.trim(),
        docId: 'BasicDetail',
      );

      final id = await basicDetailsRepository.addBasicDetail(basicDetail);
      deviceStorage.writeIfNull('IsBasicDetailsUpdated', true);

      /// Update Selected basic Detail Status
      //basicDetail.id = id;
      await basic(basicDetail);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh Profession details data
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

  Future addNewBasicDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Basic Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (gender.value.isEmpty) {
        TLoaders.errorSnackBar(title: 'Error', message: 'Select Gender');
        TFullScreenLoader.stopLoading();
        return;
      } else {
        if (!basicDetailsFormKey.currentState!.validate()) {
          TFullScreenLoader.stopLoading();
          return;
        }
      }

      /// save Basic Detail Data
      final basicDetail = BasicDetailModel(
        id: '',
        name: name.value.trim(),
        gender: gender.value.trim(),
        birthDate: birthDate.value.trim(),
        motherTongue: motherTongue.value.trim(),
        maritalStatus: maritalStatus.value.trim(),
        profileCreater: profileCreater.value.trim(),
        docId: 'BioData',
      );

      final id = await basicDetailsRepository
          .addBasicDetailToUserCollection(basicDetail);
      deviceStorage.writeIfNull('IsBasicDetailsUpdated', true);

      /// Update Selected basic Detail Status
      //basicDetail.id = id;
      await basic(basicDetail);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Details has been saved successfully');

      /// Refresh Profession details data
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
    name.close();
    //gender.close();
    //birthDate.close();
    //maritalStatus.clear();
    // profileCreater.clear();
    basicDetailsFormKey.currentState!.reset();
  }
}
