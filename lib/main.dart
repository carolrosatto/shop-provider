// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/models/cart.dart';
import 'package:provider_shop/models/order_list.dart';
import 'package:provider_shop/models/product_list.dart';
import 'package:provider_shop/pages/cart_page.dart';
import 'package:provider_shop/pages/orders_page.dart';
import 'package:provider_shop/pages/product_detail_page.dart';
import 'package:provider_shop/pages/product_form_page.dart';
import 'package:provider_shop/pages/products_overview_page.dart';
import 'package:provider_shop/pages/products_page.dart';
import 'package:provider_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop/utils/color_palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: CustomPalette.backgroundLight,
              foregroundColor: CustomPalette.brandPrimaryLight,
              elevation: 0,
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: CustomPalette.brandSecondaryLight),
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: CustomPalette.backgroundLight),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (context) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDERS: (context) => OrdersPage(),
          AppRoutes.PRODUCTS: (context) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
