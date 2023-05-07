import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dyslexic_reader/style_generator.dart';

Widget createContext(Function(BuildContext context) contextFunc) {
  return Builder(
    builder: (BuildContext context) {
      contextFunc(context);
      return const Placeholder();
    },
  );
}

void styleTestMain() {
  testWidgets('Style Generator creates correct fonts',
      (WidgetTester tester) async {
    await tester.pumpWidget(createContext(styleTestNormal));
    await tester.pumpWidget(createContext(styleTestBold));
  });
}

void styleTestNormal(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(normal: true),
  );

  TextStyle style = test.getNextStyle();
  expect(style, const TextStyle());
}

void styleTestBold(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(bold: true),
  );

  TextStyle style = test.getNextStyle();
  expect(style.fontWeight, FontWeight.w900);
}

void styleTestBoldAndNormal(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(bold: true),
  );

  TextStyle style = test.getNextStyle();
  expect(style.fontWeight, FontWeight.w900);
}
