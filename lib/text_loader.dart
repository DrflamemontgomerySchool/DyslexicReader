import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

// class TextLoader extends StatelessWidget {
  const TextLoader(
      {super.key, required this.str, required this.rules, this.seed});

  final String str;
  final StyleRules rules;
  final int? seed;

  TextSpan _formatWord(StyleGenerator styleGenerator, String word) {
    return TextSpan(
      text: '${styleGenerator.formatWord(word)} ',
      style: styleGenerator.getNextStyle(),
    );
  }

  List<TextSpan> _createWords(StyleGenerator styleGenerator, String line) {
    return [
      for (String word in line.split(' ')) _formatWord(styleGenerator, word),
      const TextSpan(text: '\n'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    StyleGenerator generator = StyleGenerator(
      rules: rules,
      seed: seed,
    );

    return RichText(
      text: TextSpan(
          text: '',
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            for (String line in str.split('\n')) _createWords(generator, line)
          ].expand((i) => i).toList()),
    );
  }
}
