import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';

class ContentScroller extends StatelessWidget {
  const ContentScroller(
      {super.key, required this.paragraphs, required this.rules, this.seed});

  final List<String> paragraphs;
  final StyleRules rules;
  final int? seed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemCount: paragraphs.length,
      itemBuilder: (BuildContext context, int index) {
        return TextLoader(
          seed: ((seed ?? hashCode) / (index + 1)).round(),
          str: paragraphs[index],
          rules: rules,
        );
      },
    );
  }
}
