import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider_shop/models/cart_item.dart';
import 'package:provider_shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          productName: existingItem.productName,
          productImage: existingItem.productImage,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          productName: product.name,
          productImage: product.imageUrl,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          productName: existingItem.productName,
          productImage: existingItem.productImage,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
