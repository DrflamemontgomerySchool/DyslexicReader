import 'package:flutter/material.dart';

class ShapedRow extends StatelessWidget {
  const ShapedRow({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.decoration,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  Widget buildPaddedChild(BuildContext context, Widget child) {
    return Container(
      decoration: decoration,
      margin: margin,
      padding: padding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (Widget child in children) buildPaddedChild(context, child),
      ],
    );
  }
}
