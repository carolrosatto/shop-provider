import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider_shop/data/products_data.dart';
import 'package:provider_shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = productsData;
  bool _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble.toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((prd) => prd.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    int index = _items.indexWhere((prd) => prd.id == product.id);

    if (index >= 0) {
      _items.removeWhere((prd) => prd.id == product.id);
      notifyListeners();
    }
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
