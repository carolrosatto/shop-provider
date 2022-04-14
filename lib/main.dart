import 'package:flutter/material.dart';
import 'package:provider_shop/pages/product_detail_page.dart';
import 'package:provider_shop/pages/products_overview_page.dart';
import 'package:provider_shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.red),
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
