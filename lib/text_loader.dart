import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextLoader extends StatelessWidget {
  const TextLoader({super.key, required this.str});

  final String str;

  TextSpan _createWord(StyleGenerator styleGenerator, String word) {
    return TextSpan(
      text: '$word ',
      style: styleGenerator.getNextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    StyleGenerator generator = StyleGenerator(
      context: context,
      rules: const StyleRules(
        bold: true,
        normal: true,
        randomSize: true,
        // color: [
        //   Colors.red,
        //   Colors.blue,
        //   Colors.green,
        // ],
      ),
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