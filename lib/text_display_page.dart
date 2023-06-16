import 'dart:math';

import 'package:dyslexic_reader/labeled_checkbox.dart';
import 'package:dyslexic_reader/markdown_test.dart';
import 'package:dyslexic_reader/page_scroller.dart';
import 'package:dyslexic_reader/shaped_row.dart';
import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/test_input.dart';
import 'package:dyslexic_reader/test_input_holder.dart';
import 'package:dyslexic_reader/text_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

import 'content_scroller.dart';

class TextDisplayPage extends StatelessWidget {
  TextDisplayPage({super.key});

  final ValueNotifier<StyleRules> _rules =
      ValueNotifier<StyleRules>(StyleRules());
  late final int seed = hashCode;
  final TestInputHolder testInputHolder = TestInputHolder(
    text: 'Test Tex"t"that"continues"a"lot',
    readOnly: false,
  );

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
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        /*child: MarkdownTest(
          data: "test text for markdown",
          rules: value,
          seed: hashCode,
        ),*/
        // child: TestInput(str: "Test", rules: value, seed: seed),
        child: Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: testInputHolder.buildInput(value, seed),
        ),
        // child: TextField(
        //   maxLines: null,
        //   expands: true,
        // ),
        // child: Container(
        //   margin: const EdgeInsets.only(
        //     left: 16.0,
        //     right: 16.0,
        //   ),
        //   child: PageScroller(
        //     rules: _rules.value,
        //     seed: seed,
        //   ),
        // ),
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
