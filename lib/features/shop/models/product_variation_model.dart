class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salesPrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salesPrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Create empty function for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Json format
  toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalesPrice': salesPrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  /// Map Json oriented document snapshot from Firebase to model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      sku: data['SKU'] ?? '',
      image: data['Image'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salesPrice: double.parse((data['SalesPrice'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      attributeValues: Map<String, String>.from(data['AttributeValues']),
    );
  }
}
