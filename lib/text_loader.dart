import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextLoader extends StatelessWidget {
  const TextLoader({super.key, required this.str, required this.rules});

  final String str;
  final StyleRules rules;

  TextSpan _formatWord(StyleGenerator styleGenerator, String word) {
    return TextSpan(
      text: '${styleGenerator.formatWord(word)} ',
      style: styleGenerator.getNextStyle(),
    );
  }

  List<TextSpan> _createWord(StyleGenerator styleGenerator, String word) {
    final List<String> splitWords = word.split('\n');
    if (splitWords.length == 1 && splitWords[0].length == word.length) {
      return [_formatWord(styleGenerator, word)];
    }

    final List<TextSpan> words = [];

    // shadowing word because it is more verbose and I don't use
    // the original word anymore
    for (String word in splitWords) {
      words.add(_formatWord(styleGenerator, '$word\n'));
    }

    return words;
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
          ].expand((i) => i).toList()),
    );
  }
}
