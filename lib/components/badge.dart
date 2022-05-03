// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider_shop/utils/color_palette.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? backgroundColor;

  const Badge({
    Key? key,
    required this.child,
    required this.value,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 9,
          top: 9,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: CustomPalette.backgroundLight,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
