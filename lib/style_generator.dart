import "dart:math";
import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleGenerator {
  StyleGenerator({required this.rules, this.seed}) {
    wordRules = rules.getWordRules();
  }

  late int _seed = seed ?? hashCode;
  final int? seed;
  final StyleRules rules;
  late final Random rng = Random(seed);
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

    if (wordRules.isEmpty) {
      _seed++;
      return TextStyle(
        fontSize: fontSize,
        fontFamily: rules.randomFonts ? _fonts[_seed % _fonts.length] : null,
      );
    }
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

    _seed++;

    return TextStyle(
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      fontSize: fontSize,
      fontFamily: rules.randomFonts ? _fonts[_seed % _fonts.length] : null,
    );
  }

  static final List<String?> _fonts = [
    GoogleFonts.dancingScript().fontFamily,
    GoogleFonts.oswald().fontFamily,
    GoogleFonts.ptSerif().fontFamily,
    GoogleFonts.spaceGrotesk().fontFamily,
  ];
}

enum WordRules { normal, bold }

class StyleRules {
  StyleRules({
    this.normal = true,
    this.bold = true,
    this.randomSize = true,
    this.nicerNumbers = true,
    this.randomFonts = true,
    this.color,
  });

  bool normal;
  bool bold;
  bool randomSize;
  bool randomFonts;
  bool nicerNumbers;
  List<Color>? color;

  List<WordRules> getWordRules() {
    List<WordRules> wordRules = [];
    if (normal) wordRules.add(WordRules.normal);
    if (bold) wordRules.add(WordRules.bold);

    return wordRules;
  }

  @override
  bool operator ==(Object other) {
    if (other is! StyleRules) return false;
    return other.normal == normal &&
        other.bold == bold &&
        other.randomSize == randomSize &&
        other.randomFonts == randomFonts &&
        other.nicerNumbers == nicerNumbers;
  }
}
