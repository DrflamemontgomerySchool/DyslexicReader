import "dart:math";
import 'package:flutter/material.dart';

class StyleGenerator {
  StyleGenerator({required this.context, required this.rules}) {
    wordRules = rules.getWordRules();
  }

  final BuildContext context;
  final StyleRules rules;
  final Random rng = Random();
  late final List<WordRules> wordRules;

  int wordRuleIndex = -1;
  int colorStyleIndex = -1;

  Color? _getFontColor() {
    if (rules.color == null) return null;
    if (rules.color!.isEmpty) return null;

    colorStyleIndex = (colorStyleIndex + 1) % rules.color!.length;
    return rules.color![colorStyleIndex];
  }

  TextStyle getNextStyle() {
    wordRuleIndex = (wordRuleIndex + 1) % wordRules.length;
    FontWeight? fontWeight;
    FontStyle? fontStyle;
    double? fontSize = rules.randomSize ? rng.nextInt(3) * 3 + 14 : null;
    Color? color = _getFontColor();

    switch (wordRules[wordRuleIndex]) {
      case WordRules.bold:
        fontWeight = FontWeight.w900;
        break;
      case WordRules.normal:
        break;
    }

    return TextStyle(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      fontSize: fontSize,
    );
  }
}

enum WordRules { normal, bold }

class StyleRules {
  const StyleRules(
      {this.normal = false,
      this.bold = false,
      this.randomSize = false,
      this.color});

  final bool normal;
  final bool bold;
  final bool randomSize;
  final List<Color>? color;

  List<WordRules> getWordRules() {
    List<WordRules> wordRules = [];
    if (normal) wordRules.add(WordRules.normal);
    if (bold) wordRules.add(WordRules.bold);

    return wordRules;
  }
}
