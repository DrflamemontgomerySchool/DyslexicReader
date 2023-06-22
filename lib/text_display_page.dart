import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:dyslexic_reader/labeled_checkbox.dart';
import 'package:dyslexic_reader/shaped_row.dart';
import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/test_input_holder.dart';
import 'package:flutter/material.dart';

class TextDisplayPage extends StatelessWidget {
  TextDisplayPage({super.key, this.text});

  final ValueNotifier<StyleRules> _rules =
      ValueNotifier<StyleRules>(StyleRules());
  late final int seed = hashCode;
  final String? text;
  late final TestInputHolder testInputHolder = TestInputHolder(
    text: text ?? "Begin Writing...",
    readOnly: false, //text != null,
  );

  Function(bool?) _changeRules(Function(bool? value) fn) {
    return (value) {
      fn(value);
      _rules.notifyListeners();
    };
  }

  Widget buildMainContent(BuildContext context, StyleRules value) {
    return Scaffold(
      drawer: const AppSideMenu(),
      appBar: AppBar(
        title: ShapedRow(
          /*decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5.0),
          ),*/
          wrapper: (BuildContext context, Widget child) => Material(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5.0),
            child: child,
          ),
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.only(right: 10),
          children: [
            LabeledCheckBox(
              onChanged: _changeRules((value) => _rules.value.bold = value!),
              value: _rules.value.bold,
              label: const Text("Bold"),
            ),
            LabeledCheckBox(
              onChanged: _changeRules((value) => _rules.value.normal = value!),
              value: _rules.value.normal,
              label: const Text("Normal"),
            ),
            LabeledCheckBox(
              onChanged:
                  _changeRules((value) => _rules.value.randomSize = value!),
              value: _rules.value.randomSize,
              label: const Text("Change Size"),
            ),
            LabeledCheckBox(
              onChanged:
                  _changeRules((value) => _rules.value.randomFonts = value!),
              value: _rules.value.randomFonts,
              label: const Text("Change Fonts"),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: testInputHolder.buildInput(value, seed),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _rules,
      builder: (BuildContext context, value, Widget? child) =>
          buildMainContent(context, value),
    );
  }
}
