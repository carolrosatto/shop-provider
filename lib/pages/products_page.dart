// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/components/drawer.dart';
import 'package:provider_shop/components/product_item.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/utils/app_routes.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        title: Text("Gerenciar produtos"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM),
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: products.items[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
