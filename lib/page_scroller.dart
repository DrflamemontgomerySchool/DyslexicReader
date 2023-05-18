import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class PageScroller extends StatelessWidget {
  const PageScroller({super.key, required this.rules, this.seed});

  final StyleRules rules;
  final int? seed;

  @override
  Widget build(BuildContext context) {
    Faker faker = Faker(seed: seed ?? hashCode);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewport) =>
          SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: viewport.maxWidth),
          child: Center(
            child: TextLoader(
              seed: seed ?? hashCode,
              rules: rules,
              str: faker.lorem
                  .sentences(10 * 20)
                  .reduce((value, element) => value += '$element\n'),
            ),
          ),
        ),
      ),
    );
  }
}
