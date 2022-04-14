// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/components/product_item.dart';
import 'package:provider_shop/models/product.dart';
import 'package:provider_shop/data/products_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = productsData;
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha loja'),
        ),
        body: GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: loadedProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) =>
                ProductItem(product: loadedProducts[index])));
  }
}
