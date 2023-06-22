import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextStyler {
  static const String _punctuationString = "'\";:,\\.\\[\\]\\(\\){}";
  static final RegExp _punctuationRegexMatch =
      RegExp('([^$_punctuationString]*)([$_punctuationString]+)(.*)');
  static TextSpan _formatWord(
      StyleGenerator styleGenerator, TextStyle? style, String word) {
    if (word.isEmpty) return TextSpan(text: " ", style: style);

    TextStyle? formattedStyle = style?.merge(styleGenerator.getNextStyle());
    RegExpMatch? match = _punctuationRegexMatch.firstMatch(word);
    if (match != null) {
      List<TextSpan> text = [];
      TextStyle? punctuationStyle =
          formattedStyle?.merge(TextStyle(fontFamily: style?.fontFamily));

      while (match != null && match.groupCount > 0) {
        if (match.group(1) != "") {
          text.add(TextSpan(text: match.group(1), style: formattedStyle));
        }
        text.add(TextSpan(text: match.group(2), style: punctuationStyle));

        String? lastWord = match.group(3);
        match = _punctuationRegexMatch.firstMatch(match.group(3) ?? "");

        if (match?.group(3) == null) {
          text.add(TextSpan(text: '$lastWord ', style: formattedStyle));
        }
      }
      return TextSpan(children: text);
    }
    return TextSpan(
      text: '${styleGenerator.formatWord(word)} ',
      style: formattedStyle,
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
