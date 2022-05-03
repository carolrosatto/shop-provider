// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider_shop/components/badge.dart';
import 'package:provider_shop/components/drawer.dart';
import 'package:provider_shop/components/product_grid.dart';
import 'package:provider_shop/models/cart.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/utils/app_routes.dart';
import 'package:provider_shop/utils/color_palette.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      backgroundColor: CustomPalette.backgroundLight,
      appBar: AppBar(bottomOpacity: 0, actions: [
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
            color: CustomPalette.brandPrimaryLight,
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
            icon: Icon(Icons.shopping_cart_outlined),
            color: CustomPalette.brandPrimaryLight,
          ),
          builder: (ctx, cart, child) => Badge(
            value: cart.itemsCount.toString(),
            child: child!,
          ),
        )
      ]),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 20),
                    child: Text(
                      "Nome da loja",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Todos os produtos",
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomPalette.textSecondaryColor,
                      ),
                    ),
                  ),
                  Expanded(child: ProductGrid()),
                ],
              ),
            ),
      drawer: AppDrawer(),
    );
  }
}
