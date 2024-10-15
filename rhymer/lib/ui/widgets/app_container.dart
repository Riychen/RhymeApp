import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
        super.key,
        required this.child,
        this.width,
        this.margin,
        this.padding = const EdgeInsets.only(left: 12),
        this.height
  });

  final double ?height;
  final double ?width;
  final EdgeInsets ?margin;
  final Widget child;
  final EdgeInsets padding;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: child);
  }
}