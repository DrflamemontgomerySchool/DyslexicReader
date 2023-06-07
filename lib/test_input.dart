import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_styler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestInput extends StatelessWidget {
  TestInput({
    super.key,
    required this.str,
    required this.rules,
    this.seed,
    this.onTextChange,
    this.readOnly = true,
  }) : controller = TestController(text: str, rules: rules, seed: seed);

  final bool readOnly;
  final String str;
  final StyleRules rules;
  final int? seed;
  final TextEditingController controller;
  final Function(String)? onTextChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      expands: true,
      controller: controller,
      style: Theme.of(context).textTheme.bodyText2,
      onChanged: onTextChange,
      readOnly: readOnly,
    );
  }
}

class TestController extends TextEditingController {
  TestController({required this.rules, this.seed, required super.text});

  final StyleRules rules;
  final int? seed;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      style: style,
      children: TextStyler.createWords(rules, seed, style, text),
    );
  }
}
