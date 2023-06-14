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
  TestController({required this.rules, this.seed, required super.text}) {
    StyleGenerator styleGenerator = StyleGenerator(rules: rules, seed: seed);

    generatedStyles = [
      for (int styleIdx = 0; styleIdx < _GENERATED_STYLE_LENGTH; styleIdx++)
        styleGenerator.getNextStyle()
    ];
  }

  // ignore: constant_identifier_names
  static const int _GENERATED_STYLE_LENGTH = 20;

  final StyleRules rules;
  final int? seed;

  late final List<TextStyle> generatedStyles;

  List<TextSpan> _generateStyledText(String words, TextStyle? style) {
    final List<TextSpan> words = [];
    int styleIdx = 0;
    for (String word in text.split(' ')) {
      words.add(
        TextSpan(
          text: '$word ',
          style: style?.merge(
            generatedStyles[styleIdx],
          ),
        ),
      );
      styleIdx++;
      styleIdx %= _GENERATED_STYLE_LENGTH;
    }
    return words;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);

    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(children: _generateStyledText(text, style));
    }

    return TextSpan(
      style: style,
      children: [
        TextSpan(text: value.composing.textBefore(value.text)),
        TextSpan(
          children: _generateStyledText(
              value.composing.textInside(value.text), style),
        ),
        TextSpan(text: value.composing.textAfter(value.text))
      ],
    );
  }
}
