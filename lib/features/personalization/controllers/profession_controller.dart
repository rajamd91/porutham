import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poruththam_app/data/repositories/profile/profession_repository.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';
import '../models/profession_model.dart';

class ProfessionController extends GetxController {
  static ProfessionController get instance => Get.find();

  //final _auth = FirebaseAuth.instance;

  /// Variables
  final deviceStorage = GetStorage();
  final education = 'Degree'.obs;
  final educationDetail = TextEditingController();
  final employedIn = 'Not Working'.obs;
  final occupation = 'Home Maker'.obs;
  final occupationDetail = TextEditingController();
  final income = 'No Income'.obs;
  GlobalKey<FormState> professionDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  final profileLoading = false.obs;
  RxBool refreshData = true.obs;
  final Rx<ProfessionDetailModel> selectedProfessionDetail =
      ProfessionDetailModel.empty().obs;
  final professionDetailsRepository = Get.put(ProfessionRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;
  final _db = FirebaseFirestore.instance;
  final _professionRepo = Get.put(ProfessionRepository());
  final Rx<ProfessionDetailModel> profession =
      ProfessionDetailModel.empty().obs;

  final List<String> educationList = [
    'Degree',
    'Master Degree',
    'PhD',
    'Diploma',
    'Hsc',
    'SSLC',
    'School Level'
  ];

  final List<String> employedInList = [
    'Not Working',
    'Private',
    'Government',
    'Self Employed',
    'Business',
    'NRI',
  ];

  final List<String> occupationList = [
    'Home Maker',
    'Software Professional',
    'Doctor',
    'Engineer',
    'Auditor',
    'IAS/IPS/etc...',
    'Architect',
    'Entrepreneur',
    'Employee',
    'Teacher',
    'Lawyer',
    'Others',
  ];

  List<String> incomeRanges = [];

  @override
  void onInit() {
    super.onInit();
    fetchProfessionRecord();
    generateIncomeRanges();
  }

  void generateIncomeRanges() {
    incomeRanges.add('No Income');
    // From 0-1 Lakh to 1-10 Lakhs with 1 Lakh increment
    for (int i = 1; i <= 10; i++) {
      incomeRanges.add('$i - ${i + 1} Lakhs');
    }

    // From 10-12 Lakhs to 18-20 Lakhs with 2 Lakhs increment
    for (int i = 10; i < 20; i += 2) {
      incomeRanges.add('$i - ${i + 2} Lakhs');
    }

    // From 20-25 Lakhs to 45-50 Lakhs with 5 Lakhs increment
    for (int i = 20; i < 50; i += 5) {
      incomeRanges.add('$i - ${i + 5} Lakhs');
    }

    // From 50-60 Lakhs to 90-100 Lakhs (1 Crore) with 10 Lakhs increment
    for (int i = 50; i <= 100; i += 10) {
      if (i == 100) {
        incomeRanges.add('Above 1 Crore');
      } else {
        incomeRanges.add('$i - ${i + 10} Lakhs');
      }
    }
  }

  void updateEducation(String? newValue) {
    if (newValue != null) {
      education.value = newValue;
    }
  }

  void updateEmployedIn(String? newValue) {
    if (newValue != null) {
      employedIn.value = newValue;
    }
  }

  void updateOccupation(String? newValue) {
    if (newValue != null) {
      occupation.value = newValue;
    }
  }

  void updateIncome(String? newValue) {
    if (newValue != null) {
      income.value = newValue;
    }
  }

  Future<void> fetchProfessionRecord() async {
    try {
      profileLoading.value = true;
      final profession =
          await professionDetailsRepository.fetchProfessionDetails();
      this.profession(profession);
    } catch (e) {
      profession(ProfessionDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getProfessionData() {
    const docId = "ProfessionDetail";
    return _professionRepo.getProfessionDetail('ProfessionDetail');
  }

  Future<ProfessionDetailModel> sGetData() async {
    final ttt = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .doc('ProfessionDetail')
        //.where("docId", isEqualTo: "BasicDetail")
        .get();

    // var bbb = ttt.data();
    // final result =
    //     await _db.collection('Users').doc(userId).collection('BioData').get();
    // var sss = await result.collection('BioData').doc('BasicDetails').get();
    // final basicDetail = ttt.docs
    //     .map((documentSnapshot) =>
    //         BasicDetailModel.fromDocumentSnapshot(documentSnapshot))
    //     //.toList()
    //     .single;
    final professionDetail = ProfessionDetailModel.fromDocumentSnapshot(ttt);

    return professionDetail;
    // return ttt;
  }

  Future<ProfessionDetailModel> getData() async {
    final ttt = await _db
        .collection('Users')
        .doc(userId)
        .collection('BioData')
        .where("DocId", isEqualTo: "ProfessionDetail")
        .get();

    //var bbb = ttt.data();
    // final result =
    //     await _db.collection('Users').doc(userId).collection('BioData').get();
    //var sss = await result.collection('BioData').doc('BasicDetails').get();
    final professionDetail = ttt.docs
        .map((ttt) => ProfessionDetailModel.fromDocumentSnapshot(ttt))
        .single;
    return professionDetail;
    // final result =
    //     await _db.collection('Users').doc(userId).collection('BioData').get();
    // final professionDetail = result.docs
    //     .map((documentSnapshot) =>
    //         ProfessionDetailModel.fromDocumentSnapshot(documentSnapshot))
    //     .single;
    // return professionDetail;
  }

  Future<List<ProfessionDetailModel>> getAllUserProfessions() async {
    try {
      final professions =
          await professionDetailsRepository.fetchUserProfessionDetails();
      // selectedAddress.value = addresses.firstWhere(
      //         (element) => element.selectedAddress,
      //     orElse: () => AddressModel.empty());
      return professions;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  getSingleProfessionDetails() async {
    try {
      final professionDetails =
          await professionDetailsRepository.fetchSingleProfessionDetail();

      return professionDetails;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'professionDetail Not Found', message: e.toString());
      return [];
    }
  }

  // Future selectProfessionDetail(ProfessionDetailModel newSelectedProfessionDetail) async {
  //   try {
  //     Get.defaultDialog(
  //       title: '',
  //       onWillPop: () async {
  //         return false;
  //       },
  //       barrierDismissible: false,
  //       backgroundColor: Colors.transparent,
  //       content: const CircularProgressIndicator(),
  //     );
  //
  //     /// Clear the "selected" field
  //     if (selectedProfessionDetail.value.id.isNotEmpty) {
  //       await professionDetailsRepository.updateSelectedField(
  //           selectedProfessionDetail.value.id, false);
  //     }
  //
  //     /// Assign selected address
  //     newSelectedProfessionDetail.selectedProfessionDetail = true;
  //     selectedProfessionDetail.value = newSelectedBasicDetail;
  //
  //     /// Get the "selected" field to true for the newly selected address
  //     await professionDetailsRepository.updateSelectedField(
  //         selectedProfessionDetail.value.id, true);
  //
  //     Get.back();
  //   } catch (e) {
  //     TLoaders.errorSnackBar(
  //         title: 'Error in Selection', message: e.toString());
  //   }
  // }

  Future addNewProfessionDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Profession Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!professionDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save ProfessionDetail Data
      final professionDetail = ProfessionDetailModel(
        id: '',
        education: education.value.trim(),
        educationDetail: educationDetail.text.trim(),
        employedIn: employedIn.value.trim(),
        occupation: occupation.value.trim(),
        occupationDetail: occupationDetail.text.trim(),
        income: income.value.trim(),
        docId: 'ProfessionDetail',
      );

      final id = await professionDetailsRepository
          .addProfessionDetail(professionDetail);
      deviceStorage.writeIfNull('IsProfessionDetailsUpdated', true);

      /// Update Selected Profession Detail Status
      //professionDetail.id = id;
      await selectedProfessionDetail(professionDetail);

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

  Future addNewProfessionDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Profession Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!professionDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save ProfessionDetail Data
      final professionDetail = ProfessionDetailModel(
        id: '',
        education: education.value.trim(),
        educationDetail: educationDetail.text.trim(),
        employedIn: employedIn.value.trim(),
        occupation: occupation.value.trim(),
        occupationDetail: occupationDetail.text.trim(),
        income: income.value.trim(),
        docId: 'BioData',
      );

      final id = await professionDetailsRepository
          .addProfessionDetailToUserCollection(professionDetail);
      deviceStorage.writeIfNull('IsProfessionDetailsUpdated', true);

      /// Update Selected Profession Detail Status
      //professionDetail.id = id;
      await selectedProfessionDetail(professionDetail);

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
    education.close();
    educationDetail.clear();
    employedIn.close();
    occupation.close();
    occupationDetail.clear();
    income.close();
    professionDetailsFormKey.currentState!.reset();
  }
}
