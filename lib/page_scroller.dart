import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

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
