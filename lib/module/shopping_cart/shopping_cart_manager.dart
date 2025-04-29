import 'package:rxdart/rxdart.dart';

class CartManager {
  final BehaviorSubject<Map<String, int>> _cartItems =
      BehaviorSubject.seeded({});

  Stream<Map<String, int>> get cartItemsStream => _cartItems.stream;

  Map<String, int> get cartItems => _cartItems.value;

  void addToCart(String productId, {int quantity = 1}) {
    final currentItems = Map<String, int>.from(_cartItems.value);
    if (currentItems.containsKey(productId)) {
      currentItems[productId] = currentItems[productId]! + quantity;
    } else {
      currentItems[productId] = quantity;
    }
    _cartItems.add(currentItems);
  }

  void removeFromCart(String productId) {
    final currentItems = Map<String, int>.from(_cartItems.value);
    currentItems.remove(productId);
    _cartItems.add(currentItems);
  }

  void increaseQuantity(String productId) {
    addToCart(productId);
  }

  void decreaseQuantity(String productId) {
    final currentItems = Map<String, int>.from(_cartItems.value);
    if (currentItems.containsKey(productId)) {
      if (currentItems[productId]! > 1) {
        currentItems[productId] = currentItems[productId]! - 1;
      } else {
        currentItems.remove(productId);
      }
      _cartItems.add(currentItems);
    }
  }

  void updateCart(Map<String, int> newCart) {
    _cartItems.add(newCart);
  }

  void clearCart() {
    _cartItems.add({});
  }

  void dispose() {
    _cartItems.close();
  }
}

final cartManager = CartManager();
