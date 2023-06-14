import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextStyler {
  static TextSpan _formatWord(
      StyleGenerator styleGenerator, TextStyle? style, String word) {
    return TextSpan(
      text: '${styleGenerator.formatWord(word)} ',
      style: style?.merge(styleGenerator.getNextStyle()),
    );
  }

  static List<TextSpan> createWords(
      StyleRules rules, int? seed, TextStyle? style, String line) {
    StyleGenerator styleGenerator = StyleGenerator(rules: rules, seed: seed);
    return [
      for (String word in line.split(' '))
        TextStyler._formatWord(styleGenerator, style, word),
      const TextSpan(text: '\n'),
    ];
  }

  static List<TextSpan> createWordsWithStyle(TextStyle style, String line) {
    return [
      for (String word in line.split(' ')) TextSpan(style: style, text: word)
    ];
  }
}
