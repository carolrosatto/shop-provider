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

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
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
