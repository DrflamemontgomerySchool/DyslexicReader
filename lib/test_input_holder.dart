import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/test_input.dart';

class TestInputHolder {
  TestInputHolder({required this.text, this.readOnly = false});

  String text;
  final bool readOnly;

  TestInput buildInput(StyleRules rules, int? seed) {
    TestInput input = TestInput(
      str: text,
      rules: rules,
      onTextChange: (str) => text = str,
      seed: seed,
      readOnly: readOnly,
    );

    return input;
  }
}
