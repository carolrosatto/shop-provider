// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(children: [
        Card(
          child: Row(children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 20),
            ),
          ]),
        )
      ]),
    );
  }
}
