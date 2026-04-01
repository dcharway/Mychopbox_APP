import 'package:flutter/foundation.dart';
import '../models/shs/shs_product.dart';

/// Provider that manages the SHS supplies shopping cart state.
class ShsCartProvider extends ChangeNotifier {
  final List<ShsCartItem> _items = [];
  StudentInfo? _studentInfo;

  // ── Getters ──

  List<ShsCartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalQuantity =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => subtotal > 500 ? 0.0 : 25.0;

  double get totalAmount => subtotal + deliveryFee;

  StudentInfo? get studentInfo => _studentInfo;

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  // ── Cart Operations ──

  /// Add a product to the cart or increment its quantity.
  void addToCart(ShsProduct product, {int quantity = 1}) {
    final existingIndex =
        _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(ShsCartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  /// Remove a product entirely from the cart.
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Update the quantity for a specific product.
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }
    final index =
        _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  /// Increment quantity by 1.
  void incrementQuantity(String productId) {
    final index =
        _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// Decrement quantity by 1 (removes if it reaches 0).
  void decrementQuantity(String productId) {
    final index =
        _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_items[index].quantity <= 1) {
        _items.removeAt(index);
      } else {
        _items[index].quantity--;
      }
      notifyListeners();
    }
  }

  /// Check whether a product is already in the cart.
  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  /// Get quantity in cart for a specific product.
  int getQuantity(String productId) {
    final index =
        _items.indexWhere((item) => item.product.id == productId);
    return index >= 0 ? _items[index].quantity : 0;
  }

  /// Clear the entire cart.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ── Student Info ──

  void setStudentInfo(StudentInfo info) {
    _studentInfo = info;
    notifyListeners();
  }

  void clearStudentInfo() {
    _studentInfo = null;
    notifyListeners();
  }

  /// Add all essential / required items at once.
  void addAllEssentials(List<ShsProduct> essentials) {
    for (final product in essentials) {
      if (!isInCart(product.id)) {
        _items.add(ShsCartItem(product: product, quantity: 1));
      }
    }
    notifyListeners();
  }
}
