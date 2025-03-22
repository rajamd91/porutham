import 'package:get/get.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/loader.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      /// Show loader while loading products
      isLoading.value = true;

      /// Fetch Products
      final products = await productRepository.getFeaturedProducts();

      /// Assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      /// Fetch Products
      final products = await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get the product price or price range for variation
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    /// If no variation exist,return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salesPrice > 0 ? product.salesPrice : product.price)
          .toString();
    } else {
      /// Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        /// determine the price to consider (sale price if available,otherwise regular price)
        double priceToConsider =
            variation.salesPrice > 0.0 ? variation.salesPrice : variation.price;

        /// Update smallest and largest price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      /// If largest smallest prices are the same return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        /// Otherwise return a price range
        return 'SmallestPrice - \$$largestPrice';
      }
    }
  }

  /// Calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// check product stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out Of Stock';
  }
}
