// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider_shop/components/badge.dart';
import 'package:provider_shop/components/drawer.dart';
import 'package:provider_shop/components/product_grid.dart';
import 'package:provider_shop/models/cart.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/utils/app_routes.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Minha loja"), actions: [
        PopupMenuButton(
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('Todos os itens'),
              value: FilterOptions.all,
            ),
            PopupMenuItem(
              child: Text('Itens favoritos'),
              value: FilterOptions.favorite,
            ),
          ],
          icon: Icon(
            Icons.more_vert,
          ),
          onSelected: (FilterOptions selectedValue) {
            if (selectedValue == FilterOptions.favorite) {
              provider.showFavoritesOnly();
            } else {
              provider.showAll();
            }
          },
        ),
        Consumer<Cart>(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.CART);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          builder: (ctx, cart, child) => Badge(
            value: cart.itemsCount.toString(),
            child: child!,
          ),
        )
      ]),
      body: ProductGrid(),
      drawer: AppDrawer(),
    );
  }
}
