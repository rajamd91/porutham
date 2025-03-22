import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poruththam_app/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:poruththam_app/features/personalization/controllers/basic_detail_controller.dart';
import 'package:poruththam_app/features/personalization/controllers/biodata_controller.dart';
import 'package:poruththam_app/features/personalization/screens/basic_detail/add_new_basic_detail.dart';
import 'package:poruththam_app/features/personalization/screens/family_detail/add_new_family_details.dart';
import 'package:poruththam_app/features/personalization/screens/location/add_new_location_details.dart';
import 'package:poruththam_app/features/personalization/screens/physical_detail/add_new_physical_details.dart';
import 'package:poruththam_app/features/personalization/screens/profession_detail/add_new_profession_detail.dart';
import 'package:poruththam_app/features/personalization/screens/religion/add_new_religious_details.dart';
import 'package:poruththam_app/navigation_menu.dart';
import 'package:poruththam_app/utils/exceptions/firebase_auth_exceptions.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  late final Rx<User?> fireBaseUser;
  final _auth = FirebaseAuth.instance;
  final bioDataController = Get.put(BioDataController());

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main dart on App launch
  @override
  void onReady() {
    /// Remove the native splash screen
    FlutterNativeSplash.remove();

    /// Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to determine the relevant screen and redirect accordingly.
  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        /// If the user's email is verified,navigate to the NavigationMenu
        //Get.offAll(() => const NavigationMenu());
        //if (basicController.hasEmptyFields())
        if (bioDataController.basicHasEmptyFields() != true) {
          Get.offAll(() => const AddNewBasicDetailScreen());
        } else if (bioDataController.physicalHasEmptyFields() != true) {
          Get.offAll(() => const AddNewPhysicalDetailScreen());
        } else if (bioDataController.professionHasEmptyFields() != true) {
          Get.offAll(() => const AddNewProfessionDetailScreen());
        } else if (bioDataController.familyHasEmptyFields() != true) {
          Get.offAll(() => const AddNewFamilyDetailScreen());
        } else if (bioDataController.religiousHasEmptyFields() != true) {
          Get.offAll(() => const AddNewReligiousDetailScreen());
        } else if (bioDataController.locationHasEmptyFields() != true) {
          Get.offAll(() => const AddNewLocationDetailScreen());
        } else {
          Get.offAll(() => const NavigationMenu());
        }
      } else {
        /// If the user's email is not verified,navigate to the VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      /// Local storage

      deviceStorage.writeIfNull('IsFirstTime', true);

      /// Check if it's the first time launching the App.
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /*------------------ Email & Password Sign-in--------------------*/

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw "Something wrong in Format";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// [Email Authentication]-FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// [ReAuthenticate]-Re Authenticate USER
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      /// Create a Credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      /// ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } on PlatformException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /*---------------- Federated Identity & Social Sign-in-------------*/

  /// [GoogleAuthentication]-GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      /// Trigger the Authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      /// Obtain the Auth Details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      /// Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      /// Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw "Something wrong";
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// [FacebookAuthentication]-FACEBOOK

  /*----------------End Federated Identity & Social Sign-in-------------*/

  /// [LogoutUser] Valid for any Authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException {
      throw "Something wrong";
    } catch (e) {
      throw 'Something went wrong.Please try Again';
    }
  }

  /// DELETE USER-Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
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
