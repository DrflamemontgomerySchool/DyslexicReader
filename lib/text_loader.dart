import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextLoader extends StatelessWidget {
  const TextLoader({super.key, required this.str, required this.rules});

  final String str;
  final StyleRules rules;

  TextSpan _createWord(StyleGenerator styleGenerator, String word) {
    return TextSpan(
      text: '${styleGenerator.formatWord(word)} ',
      style: styleGenerator.getNextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    StyleGenerator generator = StyleGenerator(
      context: context,
      rules: rules,
    );

    return RichText(
      text: TextSpan(
          text: '',
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            for (String word in str.split(' ')) _createWord(generator, word)
          ]),
    );
  }
}
