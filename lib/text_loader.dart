import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';

class TextLoader extends StatefulWidget {
  const TextLoader({super.key, required this.str});

  final String str;

  @override
  State<StatefulWidget> createState() => _TextLoader();
}

class _TextLoader extends State<TextLoader> {
  final StyleRules _rules = StyleRules(
    bold: true,
    normal: true,
    randomSize: true,
    nicerNumbers: true,
  );

  void setBold(bool? isBold) {
    setState(() {
      _rules.bold = isBold!;
    });
  }

  void setNormal(bool? isNormal) {
    setState(() {
      _rules.normal = isNormal!;
    });
  }

  void setNicerNumbers(bool? hasNicerNumbers) {
    setState(() {
      _rules.nicerNumbers = hasNicerNumbers!;
    });
  }

  void setRandomSize(bool? hasRandomSize) {
    setState(() {
      _rules.randomSize = hasRandomSize!;
    });
  }

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
      rules: _rules,
    );

    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Bold",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Checkbox(value: _rules.bold, onChanged: setBold),
            const Text(
              "Normal",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Checkbox(value: _rules.normal, onChanged: setNormal),
            const Text(
              "Format Numbers",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Checkbox(value: _rules.nicerNumbers, onChanged: setNicerNumbers),
            const Text(
              "Random Size",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Checkbox(value: _rules.randomSize, onChanged: setRandomSize),
          ],
        ),
        RichText(
          text: TextSpan(
              text: '',
              style: Theme.of(context).textTheme.bodyText2,
              children: [
                for (String word in widget.str.split(' '))
                  _createWord(generator, word)
              ]),
        ),
      ],
    );
  }
}
