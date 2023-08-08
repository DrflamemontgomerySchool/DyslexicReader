// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/src/widgets/raw_editor.dart';

class CustomEditorMKII extends RawEditor {
  const CustomEditorMKII({
    super.key,
    required super.controller,
    required super.focusNode,
    required super.scrollController,
    required super.scrollBottomInset,
    required super.cursorStyle,
    required super.selectionColor,
    required super.selectionCtrls,
    required super.embedBuilder,
    super.scrollable = true,
    super.padding = EdgeInsets.zero,
    super.readOnly = false,
    super.placeholder,
    super.onLaunchUrl,
    super.showSelectionHandles = false,
    bool? showCursor,
    super.textCapitalization = TextCapitalization.none,
    super.maxHeight,
    super.minHeight,
    super.maxContentWidth,
    super.customStyles,
    super.customShortcuts,
    super.customActions,
    super.expands = false,
    super.autoFocus = false,
    super.enableUnfocusOnTapOutside = true,
    super.keyboardAppearance = Brightness.light,
    super.enableInteractiveSelection = true,
    super.scrollPhysics,
    super.customStyleBuilder,
    super.customRecognizerBuilder,
    super.floatingCursorDisabled = false,
    super.onImagePaste,
    super.customLinkPrefixes = const <String>[],
    super.dialogTheme,
    super.contentInsertionConfiguration,
  });

  @override
  State<StatefulWidget> createState() => CustomEditorMKIIState();
}

class CustomEditorMKIIState extends RawEditorState {
  @override
  void _didChangeTextEditingValue([bool ignoreFocus = false]) {}

  @override
  Widget build(BuildContext context) {
    print("Custom EditorState");

    return super.build(context);
  }
}

class EmptyEmbedBuilder extends EmbedBuilder {
  @override
  Widget build(BuildContext context, QuillController controller, Embed node,
      bool readOnly, bool inline, TextStyle textStyle) {
    return const Placeholder();
  }

  @override
  String get key => "emptyEmbedBuilder";
}
