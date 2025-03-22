class TPricingCalculator {
  /// Calculate price based on tax and shipping
  static double calculateTotalPrice(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = subTotal * taxAmount * shippingCost;
    return totalPrice;
  }

  /// Calculate shipping cost
  static String calculateShippingCost(double subTotal, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Calculate Tax
  static String calculateTax(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(location) {
    /// Lookup the tax rate for the given location from a tax rate database or API.
    /// Return the appropriate tax rate.
    return 0.10; // Example tax rate for 10%.
  }

  static double getShippingCost(location) {
    /// Lookup the shipping cost for the given location using a shipping rate API.
    /// Calculate the shipping cost based on various factors like distance,weight etc.
    return 5.00; // Example shipping cost of $5.
  }

  /// Sum all cart values and return total amount.
  /// static double calculateCartTotal(cartModel cart)
}
