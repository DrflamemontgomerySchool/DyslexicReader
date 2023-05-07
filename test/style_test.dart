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
    await tester.pumpWidget(createContext(styleTestNormalAndBold));
  });
}

void styleTestNormal(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(normal: true),
  );

  expect(test.getNextStyle(), const TextStyle());
  expect(test.getNextStyle(), const TextStyle());
}

void styleTestBold(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(bold: true),
  );

  expect(test.getNextStyle().fontWeight, FontWeight.w900);
  expect(test.getNextStyle().fontWeight, FontWeight.w900);
}

void styleTestNormalAndBold(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: const StyleRules(bold: true, normal: true),
  );

  expect(test.getNextStyle(), const TextStyle());
  expect(test.getNextStyle().fontWeight, FontWeight.w900);
}
