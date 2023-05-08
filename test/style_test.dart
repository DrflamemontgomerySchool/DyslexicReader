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
    rules: StyleRules(
      normal: true,
      bold: false,
      randomSize: false,
    ),
  );

  expect(test.getNextStyle(), const TextStyle(fontSize: 14));
  expect(test.getNextStyle(), const TextStyle(fontSize: 14));
}

void styleTestBold(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: StyleRules(
      bold: true,
      normal: false,
      randomSize: false,
    ),
  );

  expect(test.getNextStyle(),
      const TextStyle(fontWeight: FontWeight.w900, fontSize: 14));
  expect(test.getNextStyle(),
      const TextStyle(fontWeight: FontWeight.w900, fontSize: 14));
}

void styleTestNormalAndBold(BuildContext context) {
  StyleGenerator test = StyleGenerator(
    context: context,
    rules: StyleRules(
      bold: true,
      normal: true,
      randomSize: false,
    ),
  );

  expect(test.getNextStyle(), const TextStyle(fontSize: 14));
  expect(test.getNextStyle(),
      const TextStyle(fontWeight: FontWeight.w900, fontSize: 14));
}
