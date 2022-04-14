import 'package:flutter/material.dart';
import 'package:provider_shop/models/product.dart';
import 'package:provider_shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
