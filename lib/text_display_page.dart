import 'dart:convert';
import 'dart:typed_data';

import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:dyslexic_reader/labeled_checkbox.dart';
import 'package:dyslexic_reader/shaped_row.dart';
import 'package:dyslexic_reader/style_generator.dart';
import 'package:dyslexic_reader/test_input_holder.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

// This is the app page that allows the user
// to interact with text

class TextDisplayPage extends StatelessWidget {
  TextDisplayPage({super.key, this.text, required this.fileName});

  final String fileName;
  final ValueNotifier<StyleRules> _rules =
      ValueNotifier<StyleRules>(StyleRules());
  late final int seed = hashCode;
  final String? text;
  late final TestInputHolder testInputHolder = TestInputHolder(
    text: text ?? "Begin Writing...",
    readOnly: false,
  );

  Function(bool?) _changeRules(Function(bool? value) fn) {
    return (value) {
      fn(value);
      _rules.notifyListeners();
    };
  }

  Future<void> saveFile() async {
    final Uint8List fileData =
        Uint8List.fromList(utf8.encode(testInputHolder.text));
    XFile textFile = XFile.fromData(fileData, mimeType: "text/plain");
    await textFile.saveTo(fileName);
  }

  Widget buildMainContent(BuildContext context, StyleRules value) {
    return Scaffold(
      drawer: AppSideMenu(onSave: () {
        saveFile();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saved $fileName'),
          duration: const Duration(seconds: 1),
        ));
      }),
      appBar: AppBar(
        title: ShapedRow(
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
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyS, control: true):
            _SaveFileIntent(),
      },
      child: Actions(
        actions: {
          _SaveFileIntent: CallbackAction<_SaveFileIntent>(onInvoke: (_) async {
            await saveFile();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Saved $fileName'),
              duration: const Duration(seconds: 1),
            ));
          }),
        },
        child: ValueListenableBuilder(
          valueListenable: _rules,
          builder: (BuildContext context, value, Widget? child) =>
              buildMainContent(context, value),
        ),
      ),
    );
  }
}

class _SaveFileIntent extends Intent {
  const _SaveFileIntent();
}
