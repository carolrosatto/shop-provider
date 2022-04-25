// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/models/product.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Quer excluir o produto?"),
                          actions: [
                            TextButton(
                              child: Text("Não"),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Sim"),
                              onPressed: () {
                                Provider.of<ProductList>(
                                  context,
                                  listen: false,
                                ).deleteProduct(product);
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ));
                // Provider.of<ProductList>(
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
