import "dart:math";
import "package:intl/intl.dart";
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

  bool _isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  String formatWord(String word) {
    if (rules.nicerNumbers && _isNumeric(word)) {
      NumberFormat numFormat = NumberFormat.decimalPattern('en_us');
      return numFormat.format(int.parse(word));
    }

    return word;
  }

  Color? _getFontColor() {
    if (rules.color == null) return null;
    if (rules.color!.isEmpty) return null;

    colorStyleIndex = (colorStyleIndex + 1) % rules.color!.length;
    return rules.color![colorStyleIndex];
  }

  TextStyle getNextStyle() {
    double fontSize = 14;
    if (rules.randomSize) {
      fontSize += rng.nextInt(3) * 3;
    }

    if (wordRules.isEmpty) return TextStyle(fontSize: fontSize);
    wordRuleIndex = (wordRuleIndex + 1) % wordRules.length;
    FontWeight? fontWeight;
    FontStyle? fontStyle;
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
  StyleRules({
    this.normal = true,
    this.bold = true,
    this.randomSize = true,
    this.nicerNumbers = true,
    this.color,
  });

  bool normal;
  bool bold;
  bool randomSize;
  bool nicerNumbers;
  List<Color>? color;

  List<WordRules> getWordRules() {
    List<WordRules> wordRules = [];
    if (normal) wordRules.add(WordRules.normal);
    if (bold) wordRules.add(WordRules.bold);

    return wordRules;
  }
}
