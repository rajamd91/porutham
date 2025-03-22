import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poruththam_app/utils/helpers/loader.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/models/user_model.dart';
import '../../screens/signup/widgets/verify_email.dart';
import '../network_manager.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for hiding/showing password
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  var tFirstName = ''.obs;
  var tLastName = ''.obs;
  var tFullName = ''.obs;

  void updateFirstName(String value) {
    tFirstName.value = value;
    updateFullName();
    print(tFirstName.value);
    print(tFullName.value);
  }

  void updateLastName(String value) {
    tLastName.value = value;
    updateFullName();
    print(tLastName.value);
  }

  void updateFullName() {
    tFullName.value = '${firstName.value.text} ${lastName.value.text}';
  }

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //Form key for Form Validation
  final userRepo = Get.put(UserRepository());

  ///-- SIGNUP
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy policy Check
      if (!privacyPolicy.value) {
        TLoaders.errorSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create Account You must have to read and accept Privacy Policy and Terms of Use.');
        return;
      }

      // Register User in the Firebase Authentication & Save User data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      final snapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .doc('admin')
          .get();
      Map<String, dynamic>? data = snapshot.data();
      var temp = data!['LastProfileId'] as int;
      //var qqq = temp as int;
      temp = temp + 1;
      //qqq = qqq + 1;
      final String sss = temp.toString();

      // Save Authenticated user data in the Firebase Firestore
      final profileId = UserModel.generateProfileId(sss);
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
        profileId: profileId,
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      Map<String, dynamic> json = {'LastProfileId': temp};
      await userRepository.updateAdmin(json);

      // Show Success Message
      TLoaders.successSnackBar(
          title: "Congratulations",
          message: 'Your Account has been created!.Verify Email to continue.');

      // move to verify Email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();

      // show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
