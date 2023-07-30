import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;

class CustomEditor extends StatelessWidget {
  CustomEditor({
    super.key,
    required this.controller,
  }) {
    final List<String> textValues = controller.getPlainText().split('\n');
    int stringStart = 0;
    for (int idx = 0; idx < textValues.length; idx++) {
      _cachedParagraphs.add(CachedText(
        text: textValues[idx],
        start: stringStart,
      ));
      stringStart += textValues[idx].length;
    }
  }

  final fq.QuillController controller;
  static List<TextStyle> _cachedStyles = [];
  static List<CachedText> _cachedParagraphs = [];
  static List<Text> _cachedWidgets = [];
  static bool invalidated = true;

  static int _styleIndex = 0;

  static Text _getCachedText(int index) {
    return Text(_cachedParagraphs[index].text);
  }

  static Text _getText(CachedText cachedText) {
    List<TextSpan> children = [];
    List<String> strings = cachedText.text.split(' ');
    for (int idx = 1; idx < strings.length; idx++) {
      children.add(TextSpan(
        text: ' ${strings[idx]}',
        style: _cachedStyles[_styleIndex],
      ));
      _styleIndex++;
      _styleIndex %= 20;
    }

    return Text.rich(TextSpan(text: strings[0], children: children));
  }

  static Text getCachedText(int index) {
    if (index >= _cachedWidgets.length) {
      for (int idx = _cachedWidgets.length; index >= idx; idx++) {
        _cachedWidgets.add(_getText(_cachedParagraphs[index]));
      }
    }

    return _cachedWidgets[index];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      itemCount: _cachedParagraphs.length,
      itemBuilder: (context, index) => _getCachedText(index),
    );
  }
}

class CachedText {
  CachedText({required this.text, required this.start}) {
    end = start + text.length;
  }
  String text;
  int start;
  late int end;
  bool invalidated = false;
}
