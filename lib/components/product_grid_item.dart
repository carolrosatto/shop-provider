// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider_shop/exceptions/http_exceptions.dart';
import 'package:provider_shop/models/cart.dart';
import 'package:provider_shop/models/product.dart';
import 'package:provider_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/utils/color_palette.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    final message = ScaffoldMessenger.of(context);

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product),
          child: Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 9,
            right: 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: product.isFavorite
                    ? CustomPalette.brandSecondaryLight
                    : CustomPalette.backgroundLight,
              ),
              width: 30,
              height: 30,
              child: Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                        onPressed: () async {
                          try {
                            await product.saveFavorite();
                          } on HttpException catch (error) {
                            message.showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        iconSize: 15,
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        icon: product.isFavorite
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_outline),
                        color: product.isFavorite
                            ? CustomPalette.backgroundLight
                            : CustomPalette.brandSecondaryLight,
                      )),
            )),
        Container(
          padding: EdgeInsets.all(8),
          height: 60,
          color: CustomPalette.backgroundLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'R\$ ${product.price.toString()}',
                    style: TextStyle(
                        fontSize: 12, color: CustomPalette.textSecondaryColor),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  cart.addItem(product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Produto adicionado ao carrinho"),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "DESFAZER",
                        onPressed: () => cart.removeItem(product.id),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
//     ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           child: Image.network(
//             product.imageUrl,
//             fit: BoxFit.cover,
//           ),
//           onTap: () {
//             Navigator.of(context)
//                 .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
//           },
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.white,
//           leading: Consumer<Product>(
//             builder: (ctx, product, _) => IconButton(
//               onPressed: () async {
//                 try {
//                   await product.saveFavorite();
//                 } on HttpException catch (error) {
//                   message.showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         error.toString(),
//                       ),
//                     ),
//                   );
//                 }
//               },
//               icon: Icon(
//                   product.isFavorite ? Icons.favorite : Icons.favorite_border),
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//           ),
//           title: Column(
//             children: [
//               Text(
//                 product.name,
//                 // textAlign: TextAlign.center,
//                 maxLines: 2,
//                 style: TextStyle(
//                     color: CustomPalette.textSecondaryColor, fontSize: 14),
//               ),
//               Text(
//                 product.price.toString(),
//                 style: TextStyle(color: CustomPalette.textPrimaryColor),
//               )
//             ],
//           ),
//           trailing: IconButton(
//             icon: const Icon(Icons.shopping_cart_outlined),
//             color: Theme.of(context).colorScheme.secondary,
//             onPressed: () {
//               cart.addItem(product);
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("Produto adicionado ao carrinho"),
//                   duration: Duration(seconds: 2),
//                   action: SnackBarAction(
//                     label: "DESFAZER",
//                     onPressed: () => cart.removeItem(product.id),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
