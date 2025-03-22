class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  /// Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// convert a cartItem to a Json Map
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'BrandName': brandName,
      'SelectedVariation': selectedVariation,
    };
  }

  /// Create a cartItem from Json Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        productId: json['productId'],
        title: json['title'],
        price: json['price']?.toDouble(),
        image: json['image'],
        quantity: json['quantity'],
        variationId: json['variationId'],
        brandName: json['brandName'],
        selectedVariation: json['selectedVariation'] != null
            ? Map<String, String>.from(json['selectedVariation'])
            : null);
  }
}
