import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poruththam_app/features/personalization/models/locationDetailModel.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/profile/location_detail_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/controllers/network_manager.dart';
//import '../../../../../marriage/lib/utils/helpers/loader.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<LocationDetailModel> location = LocationDetailModel.empty().obs;

  /// Variables
  final deviceStorage = GetStorage();
  Rx<String> tCountry = ''.obs;
  final country = TextEditingController();
  var state = 'Tamil Nadu'.obs;
  var district = 'Chennai'.obs;
  final city = TextEditingController();
  final address = TextEditingController();
  final pinCode = TextEditingController();

  var stateDropdownValue = 'Tamil Nadu'.obs;
  var districtDropdownValue = 'Others'.obs;
  var isDistrictDropdownEnabled = true.obs;

  GlobalKey<FormState> locationDetailsFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation

  RxBool refreshData = true.obs;
  final locationDetailsRepository = Get.put(LocationDetailsRepository());
  final userId = AuthenticationRepository.instance.authUser!.uid;

  final List<String> statesAndUTsList = [
    'Tamil Nadu',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
    'Ladakh',
    'Jammu and Kashmir'
  ];

  final List<String> districtsList = [
    'Chennai',
    'Coimbatore',
    'Madurai',
    'Tiruchirappalli',
    'Salem',
    'Erode',
    'Tirunelveli',
    'Vellore',
    'Thoothukudi',
    'Thanjavur',
    'Dindigul',
    'Tiruppur',
    'Kanchipuram',
    'Virudhunagar',
    'Karur',
    'Nagapattinam',
    'Ramanathapuram',
    'Sivaganga',
    'Namakkal',
    'Cuddalore',
    'Krishnagiri',
    'Perambalur',
    'Dharmapuri',
    'Pudukkottai',
    'Ariyalur',
    'The Nilgiris',
    'Theni',
    'Tenkasi',
    'Kallakurichi',
    'Chengalpattu',
    'Ranipet',
    'Tirupathur',
    'Others'
  ];

  @override
  void onInit() {
    super.onInit();
    fetchLocationRecord();
  }

  void updateState(String? newValue) {
    if (newValue != null) {
      state.value = newValue;
      if (state.value != 'Tamil Nadu') {
        district.value = 'Others';
        isDistrictDropdownEnabled.value = false;
      } else {
        district.value = 'Chennai';
        isDistrictDropdownEnabled.value = true;
      }
    }
  }

  void updateDistrictDropdown(String? newValue) {
    state.value = newValue ?? 'Tamil Nadu';

    if (state.value != 'Tamil Nadu') {
      district.value = 'Others';
      isDistrictDropdownEnabled.value = false;
    } else {
      isDistrictDropdownEnabled.value = true;
    }
  }

  void updateDistrict(String? newValue) {
    if (newValue != null) {
      district.value = newValue;
    }
  }

  Future<void> fetchLocationRecord() async {
    try {
      profileLoading.value = true;
      final location = await locationDetailsRepository.fetchLocationDetails();
      this.location(location);
    } catch (e) {
      location(LocationDetailModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  getLocationData() {
    return locationDetailsRepository.getLocationDetail('LocationDetail');
  }

  Future addNewLocationDetails() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Location Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!locationDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final locationDetail = LocationDetailModel(
        id: '',
        country: country.text.trim(),
        state: state.value.trim(),
        district: district.value.trim(),
        city: city.text.trim(),
        address: address.text.trim(),
        pincode: pinCode.text.trim(),
        docId: 'LocationDetail',
      );

      final id =
          await locationDetailsRepository.addLocationDetail(locationDetail);
      deviceStorage.writeIfNull('IsLocationDetailsUpdated', true);

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

  Future addNewLocationDetailsToUserCollection() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Location Details...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!locationDetailsFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// save BasicDetail Data
      final locationDetail = LocationDetailModel(
        id: '',
        country: country.text.trim(),
        state: state.value.trim(),
        district: district.value.trim(),
        city: city.text.trim(),
        address: address.text.trim(),
        pincode: pinCode.text.trim(),
        docId: 'BioData',
      );

      final id = await locationDetailsRepository
          .addLocationDetailToUserCollection(locationDetail);

      deviceStorage.writeIfNull('IsLocationDetailsUpdated', true);

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
    country.clear();
    state.close();
    district.close();
    city.clear();
    address.clear();
    pinCode.clear();
    locationDetailsFormKey.currentState!.reset();
  }

  setCountryValue(String country) {
    tCountry = country as Rx<String>;
  }
}
