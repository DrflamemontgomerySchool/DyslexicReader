import 'package:flutter/material.dart';

class PageScroller extends StatelessWidget {
  const PageScroller({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewport) =>
          SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: viewport.maxWidth),
          child: Center(child: child),
        ),
      ),
    );
  }
}
