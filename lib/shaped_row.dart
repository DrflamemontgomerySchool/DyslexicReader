import 'package:flutter/material.dart';

class ShapedRow extends StatelessWidget {
  const ShapedRow({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.decoration,
    this.wrapper,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Function(BuildContext, Widget)? wrapper;

  Widget _wrapPadding(Widget child, EdgeInsetsGeometry? padding) {
    if (padding != null) {
      return Padding(padding: padding, child: child);
    }
    return child;
  }

  Widget buildPaddedChild(BuildContext context, Widget child) {
    if (wrapper != null) {
      return _wrapPadding(
        wrapper!(
          context,
          _wrapPadding(
            child,
            padding,
          ),
        ),
        margin,
      );
    }
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
