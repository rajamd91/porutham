import 'package:get/get.dart';
import 'package:poruththam_app/features/personalization/models/biodata_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  /// Controllers
  // final email = TextEditingController();
  // final password = TextEditingController();
  // final fullName = TextEditingController();
  // final phoneNo = TextEditingController();

  ///Repositories
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  /// Step 3 - Get Use Email and pass to UserRepository to fetch user record.
  getUserData() {
    final email = _authRepo.fireBaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  /// Fetch List of user records
  Future<List<BioDataModel>> getAllUser() async {
    return await _userRepo.allUserBioData();
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}
