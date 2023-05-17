import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';

class TextTest extends StatefulWidget {
  const TextTest({super.key, required this.paragraphs});

  final List<String> paragraphs;

  @override
  _TextTestState createState() => _TextTestState();
}

class _TextTestState extends State<TextTest> {
  late ValueNotifier<StyleRules> _rules;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _rules = ValueNotifier<StyleRules>(StyleRules());
    super.initState();
  }

  Function(bool? value) _changeRules(Function(bool? value) fn) {
    return (value) {
      fn(value);
      _rules.notifyListeners();
    };
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _rules,
      builder: (context, value, child) => Column(children: [
        Row(
          children: [
            Checkbox(
              value: value.bold,
              onChanged: _changeRules((value) => _rules.value.bold = value!),
            ),
            Checkbox(
              value: value.normal,
              onChanged: _changeRules((value) => _rules.value.normal = value!),
            ),
            Checkbox(
              value: value.nicerNumbers,
              onChanged:
                  _changeRules((value) => _rules.value.nicerNumbers = value!),
            ),
            Checkbox(
              value: value.randomSize,
              onChanged:
                  _changeRules((value) => _rules.value.randomSize = value!),
            ),
          ],
        ),
        for (String str in widget.paragraphs)
          TextLoader(str: str, rules: value),
      ]),
    );
  }
}
