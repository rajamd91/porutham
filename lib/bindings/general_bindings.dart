import 'package:get/get.dart';

import '../features/authentication/controllers/network_manager.dart';
import '../features/personalization/screens/test/form_progress_indicator/form_progress_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(FormController());
    //   Get.put(AddressController());
    //   Get.put(VariationController());
    //   Get.put(CheckoutController());
  }
}
