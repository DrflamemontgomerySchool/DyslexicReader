import 'dart:math';

import 'package:dyslexic_reader/labeled_checkbox.dart';
import 'package:dyslexic_reader/page_scroller.dart';
import 'package:dyslexic_reader/shaped_row.dart';
import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';

import 'content_scroller.dart';

class TextDisplayPage extends StatelessWidget {
  TextDisplayPage({super.key});

  final ValueNotifier<StyleRules> _rules =
      ValueNotifier<StyleRules>(StyleRules());
  late final int seed = hashCode;

  Function(bool?) _changeRules(Function(bool? value) fn) {
    return (value) {
      fn(value);
      _rules.notifyListeners();
    };
  }

  Widget buildMainContent(BuildContext context, StyleRules value) {
    return Scaffold(
      appBar: AppBar(
        title: ShapedRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5.0),
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
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: PageScroller(
            rules: _rules.value,
            seed: seed,
          ),
          /*child: ContentScroller(
            seed: seed,
            paragraphs: [
              for (int index = 0; index < 10; index++)
                'Testing the \nString that has \nnew Lines\n$index'
            ],
            rules: StyleRules(bold: value.bold, normal: value.normal),
          ),*/
        ),
      ),
      // body: TextLoader(
      //   rules: value,
      //   seed: seed,
      //   str:
      //       "This is a test string for the example\nOf giving us the correct text",
      // ),
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
