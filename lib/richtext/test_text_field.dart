import 'package:dyslexic_reader/richtext/custom_editor.dart';
import 'package:dyslexic_reader/richtext/custom_editor_mkII.dart';
import 'package:dyslexic_reader/richtext/quill_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/src/widgets/raw_editor.dart';
import 'package:flutter_quill/src/widgets/cursor.dart';

import '../style_generator.dart';

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
    _controller.document.insert(0, "Test Text");
    print(_controller.document.getPlainText(0, _controller.document.length));
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
    return QuillExtension(
      controller: _controller,
      focusNode: _focusNode,
      scrollController: ScrollController(),
      scrollable: true,
      padding: EdgeInsets.zero,
      autoFocus: false,
      readOnly: false,
      expands: true,
    );
    // return QuillEditor(
    //   controller: _controller,
    //   scrollable: true,
    //   expands: true,
    //   autoFocus: false,
    //   focusNode: _focusNode,
    //   padding: EdgeInsets.zero,
    //   readOnly: false,
    //   scrollController: ScrollController(),
    // );
    // return CustomEditor(
    //   controller: _controller,
    //   styleRules: StyleRules(
    //     bold: true,
    //     normal: true,
    //     randomSize: true,
    //     randomFonts: true,
    //   ),
    // );

    // return CustomEditorMKII(
    //   controller: _controller,
    //   focusNode: FocusNode(),
    //   scrollController: ScrollController(),
    //   scrollBottomInset: 2.0,
    //   cursorStyle: const CursorStyle(
    //     backgroundColor: Colors.white,
    //     color: Colors.black,
    //   ),
    //   selectionColor: Colors.black45,
    //   selectionCtrls: EmptyTextSelectionControls(),
    //   embedBuilder: (_) => EmptyEmbedBuilder(),
    //   readOnly: true,
    //   showCursor: true,
    //   expands: true,
    //   autoFocus: true,
    // );
  }
}
