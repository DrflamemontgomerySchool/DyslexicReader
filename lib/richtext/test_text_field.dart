import 'package:dyslexic_reader/richtext/custom_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TestTextField extends StatefulWidget {
  const TestTextField({super.key});

  @override
  State<StatefulWidget> createState() => _TestTextField();
}

class _TestTextField extends State<TestTextField> {
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = QuillController.basic();
    _controller.addListener(onChange);
    _controller.onSelectionChanged = selectionChanged;
  }

  var s = 0;
  void selectionChanged(TextSelection? selection) {}

  void onChange() {
    /*const List<Attribute> att = [Attribute.bold, Attribute.italic];
    _controller.changes.first.then((value) {
      var beforeText = value.before.toList();
      var changeText = value.change.toList();

      print('$beforeText, $changeText');
    });*/

    /*if (_controller.getSelectionStyle().isNotEmpty) return;
    for (var style in _controller.getAllSelectionStyles()) {
      style.attributes.clear();
    }
    _controller.formatSelection(att[s % att.length]);
    s++;*/
  }

  @override
  Widget build(BuildContext context) {
    /*return QuillEditor(
      controller: _controller,
      scrollable: true,
      expands: true,
      autoFocus: false,
      focusNode: _focusNode,
      padding: EdgeInsets.zero,
      readOnly: false,
      scrollController: ScrollController(),
    );*/
    return CustomEditor(
      controller: _controller,
    );
  }
}
