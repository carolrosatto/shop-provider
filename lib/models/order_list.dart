import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_shop/models/cart.dart';
import 'package:provider_shop/models/cart_item.dart';
import 'package:provider_shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:provider_shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();

    final response =
        await http.get(Uri.parse('${Constants.ORDER_BASE_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, order) {
      _items.add(
        Order(
          id: orderId,
          date: DateTime.parse(order['date']),
          total: order['total'],
          products: (order['products'] as List<dynamic>).map((item) {
            return CartItem(
                id: item['id'],
                productId: item['productId'],
                productName: item['name'],
                quantity: item['quantity'],
                price: item['price'],
                productImage: item['image']);
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode(
        {
          "date": date.toIso8601String(),
          "total": cart.totalAmount,
          "products": cart.items.values
              .map(
                (cartItem) => {
                  "id": cartItem.id,
                  "productId": cartItem.productId,
                  "name": cartItem.productName,
                  "image": cartItem.productImage,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price
                },
              )
              .toList(),
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
