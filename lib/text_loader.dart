import 'package:flutter/material.dart';

class TextLoader extends StatelessWidget {
  const TextLoader({super.key, required this.str});

  final String str;

  @override
  Widget build(BuildContext context) {
    List<TextStyle> textStyles = [
      const TextStyle(fontStyle: FontStyle.italic),
      const TextStyle(fontWeight: FontWeight.bold),
    ];

    int index = 0;

    TextStyle getNextStyle() {
      index = (index + 1) % 2;
      return textStyles[index];
    }

    return RichText(
      text: TextSpan(
          text: '',
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            for (String word in str.split(' '))
              TextSpan(
                text: '$word ',
                style: getNextStyle(),
              )
          ]),
    );
  }
}
