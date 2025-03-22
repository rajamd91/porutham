import 'package:get/get.dart';
import '../../../data/repositories/banners/banner_repository.dart';
import '../../../utils/helpers/loader.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  /// Variables
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update Page Navigational Dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      /// Show loader while loading categories
      isLoading.value = true;

      /// Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      /// Assign Banners
      this.banners.assignAll(banners);

      // /// Fetch categories from data source (Firestore,API,etc..,)
      // final categories = await _categoryRepository.getAllCategories();
      //
      // /// Update the categories list
      // allCategories.assignAll(categories);
      //
      // /// Filter Featured categories
      // featuredCategories.assignAll(allCategories
      //     .where((category) => category.isFeatured && category.parentId.isEmpty)
      //     .take(8)
      //     .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      /// Remove Loader
      isLoading.value = false;
    }
  }
}
