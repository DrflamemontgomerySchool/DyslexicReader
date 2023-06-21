import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

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

  static const String _punctuationString = "'\";:,\\.\\[\\]\\(\\){}";
  static final RegExp _punctuationRegexMatch =
      RegExp('([^$_punctuationString]*)([$_punctuationString]+)(.*)');

  static TextSpan _formatWord(
      TextStyle? defaultStyle, TextStyle? style, String word, bool addSpace) {
    if (word.isEmpty) return TextSpan(text: addSpace ? " " : "", style: style);

    RegExpMatch? match = _punctuationRegexMatch.firstMatch(word);
    if (match == null) {
      return TextSpan(text: addSpace ? '$word ' : word, style: style);
    }

    List<TextSpan> text = [];
    while (match != null && match.groupCount > 0) {
      final String match1 = match.group(1) ?? "";
      final String match2 = match.group(2) ?? "";
      final String match3 = match.group(3) ?? "";

      if (match1.isNotEmpty) {
        text.add(TextSpan(
            text: match2.isEmpty && addSpace ? '$match1 ' : match1,
            style: style));
      }

      if (match2.isEmpty) break;

      text.add(TextSpan(
        text: match3.isEmpty && addSpace ? '$match2 ' : match2,
        style: style?.merge(TextStyle(fontFamily: defaultStyle?.fontFamily)),
      ));

      if (match3.isEmpty) break;
      match = _punctuationRegexMatch.firstMatch(match3);

      if (match == null) {
        text.add(TextSpan(text: addSpace ? '$match3 ' : match3, style: style));
      }
    }

    return TextSpan(children: text);
  }

  List<TextSpan> _generateStyledText(String words, TextStyle? style) {
    final List<TextSpan> words = [];
    int styleIdx = 0;
    for (String line in text.split('\n')) {
      if (line.isEmpty) {
        words.add(const TextSpan(text: '\n'));
        continue;
      }
      List<String> word = line.split(' ');
      for (int index = 0; index < word.length; index++) {
        if (word[index].isEmpty) {
          words.add(const TextSpan(text: ' '));
          continue;
        }
        words.add(_formatWord(
          style,
          style?.merge(generatedStyles[styleIdx]),
          word[index],
          index != (word.length - 1),
        ));
        styleIdx++;
        styleIdx %= _GENERATED_STYLE_LENGTH;
      }
      words.add(const TextSpan(text: '\n'));
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
