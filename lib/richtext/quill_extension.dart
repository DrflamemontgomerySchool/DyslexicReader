import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/src/widgets/text_selection.dart';
import 'package:flutter_quill/src/widgets/raw_editor.dart';
import 'package:flutter_quill/src/widgets/cursor.dart';
import 'package:flutter_quill/src/widgets/delegate.dart';
import 'package:i18n_extension/i18n_widget.dart';

class QuillExtension extends QuillEditor {
  const QuillExtension({
    super.key,
    required super.controller,
    required super.focusNode,
    required super.scrollController,
    required super.scrollable,
    required super.padding,
    required super.autoFocus,
    required super.readOnly,
    required super.expands,
  });

  @override
  QuillEditorState createState() => QuillExtensionState();
}

class QuillExtensionState extends QuillEditorState
    implements EditorTextSelectionGestureDetectorBuilderDelegate {
  final GlobalKey<EditorState> _editorKey = GlobalKey<EditorState>();
  late EditorTextSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _QuillEditorSelectionGestureDetectorBuilder(
            this, widget.detectWordBoundary);
  }

  void _requestKeyboard() {
    _editorKey.currentState!.requestKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionTheme = TextSelectionTheme.of(context);

    TextSelectionControls textSelectionControls;
    bool paintCursorAboveText;
    bool cursorOpacityAnimates;
    Offset? cursorOffset;
    Color? cursorColor;
    Color selectionColor;
    Radius? cursorRadius;

    if (isAppleOS(theme.platform)) {
      final cupertinoTheme = CupertinoTheme.of(context);
      textSelectionControls = cupertinoTextSelectionControls;
      paintCursorAboveText = true;
      cursorOpacityAnimates = true;
      cursorColor ??= selectionTheme.cursorColor ?? cupertinoTheme.primaryColor;
      selectionColor = selectionTheme.selectionColor ??
          cupertinoTheme.primaryColor.withOpacity(0.40);
      cursorRadius ??= const Radius.circular(2);
      cursorOffset = Offset(
          iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
    } else {
      textSelectionControls = materialTextSelectionControls;
      paintCursorAboveText = false;
      cursorOpacityAnimates = false;
      cursorColor ??= selectionTheme.cursorColor ?? theme.colorScheme.primary;
      selectionColor = selectionTheme.selectionColor ??
          theme.colorScheme.primary.withOpacity(0.40);
    }

    final showSelectionToolbar =
        widget.enableInteractiveSelection && widget.enableSelectionToolbar;

    final child = RawEditor(
      key: _editorKey,
      controller: widget.controller,
      focusNode: widget.focusNode,
      scrollController: widget.scrollController,
      scrollable: widget.scrollable,
      scrollBottomInset: widget.scrollBottomInset,
      padding: widget.padding,
      readOnly: widget.readOnly,
      placeholder: widget.placeholder,
      onLaunchUrl: widget.onLaunchUrl,
      contextMenuBuilder: showSelectionToolbar
          ? (widget.contextMenuBuilder ?? RawEditor.defaultContextMenuBuilder)
          : null,
      showSelectionHandles: isMobile(theme.platform),
      showCursor: widget.showCursor,
      cursorStyle: CursorStyle(
        color: cursorColor,
        backgroundColor: Colors.grey,
        width: 2,
        radius: cursorRadius,
        offset: cursorOffset,
        paintAboveText: widget.paintCursorAboveText ?? paintCursorAboveText,
        opacityAnimates: cursorOpacityAnimates,
      ),
      textCapitalization: widget.textCapitalization,
      minHeight: widget.minHeight,
      maxHeight: widget.maxHeight,
      maxContentWidth: widget.maxContentWidth,
      customStyles: widget.customStyles,
      expands: widget.expands,
      autoFocus: widget.autoFocus,
      selectionColor: selectionColor,
      selectionCtrls: widget.textSelectionControls ?? textSelectionControls,
      keyboardAppearance: widget.keyboardAppearance,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      scrollPhysics: widget.scrollPhysics,
      embedBuilder: _getEmbedBuilder,
      linkActionPickerDelegate: widget.linkActionPickerDelegate,
      customStyleBuilder: widget.customStyleBuilder,
      customRecognizerBuilder: widget.customRecognizerBuilder,
      floatingCursorDisabled: widget.floatingCursorDisabled,
      onImagePaste: widget.onImagePaste,
      customShortcuts: widget.customShortcuts,
      customActions: widget.customActions,
      customLinkPrefixes: widget.customLinkPrefixes,
      enableUnfocusOnTapOutside: widget.enableUnfocusOnTapOutside,
      dialogTheme: widget.dialogTheme,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
    );

    final editor = I18n(
      initialLocale: widget.locale,
      child: selectionEnabled
          ? _selectionGestureDetectorBuilder.build(
              behavior: HitTestBehavior.translucent,
              detectWordBoundary: widget.detectWordBoundary,
              child: child,
            )
          : child,
    );

    if (kIsWeb) {
      // Intercept RawKeyEvent on Web to prevent it from propagating to parents
      // that might interfere with the editor key behavior, such as
      // SingleChildScrollView. Thanks to @wliumelb for the workaround.
      // See issue https://github.com/singerdmx/flutter-quill/issues/304
      return RawKeyboardListener(
        onKey: (_) {},
        focusNode: FocusNode(
          onKey: (node, event) => KeyEventResult.skipRemainingHandlers,
        ),
        child: editor,
      );
    }

    return editor;
  }

  EmbedBuilder _getEmbedBuilder(Embed node) {
    final builders = widget.embedBuilders;

    if (builders != null) {
      for (final builder in builders) {
        if (builder.key == node.value.type) {
          return builder;
        }
      }
    }

    if (widget.unknownEmbedBuilder != null) {
      return widget.unknownEmbedBuilder!;
    }

    throw UnimplementedError(
      'Embeddable type "${node.value.type}" is not supported by supplied '
      'embed builders. You must pass your own builder function to '
      'embedBuilders property of QuillEditor or QuillField widgets or '
      'specify an unknownEmbedBuilder.',
    );
  }
}

class _QuillEditorSelectionGestureDetectorBuilder
    extends EditorTextSelectionGestureDetectorBuilder {
  _QuillEditorSelectionGestureDetectorBuilder(
      this._state, this._detectWordBoundary)
      : super(delegate: _state, detectWordBoundary: _detectWordBoundary);

  final QuillExtensionState _state;
  final bool _detectWordBoundary;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editor!.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {}

  @override
  void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {
    if (_state.widget.onSingleLongTapMoveUpdate != null) {
      if (renderEditor != null &&
          _state.widget.onSingleLongTapMoveUpdate!(
              details, renderEditor!.getPositionForOffset)) {
        return;
      }
    }
    if (!delegate.selectionEnabled) {
      return;
    }

    final _platform = Theme.of(_state.context).platform;
    if (isAppleOS(_platform)) {
      renderEditor!.selectPositionAt(
        from: details.globalPosition,
        cause: SelectionChangedCause.longPress,
      );
    } else {
      renderEditor!.selectWordsInRange(
        details.globalPosition - details.offsetFromOrigin,
        details.globalPosition,
        SelectionChangedCause.longPress,
      );
    }
  }

  bool _isPositionSelected(TapUpDetails details) {
    if (_state.widget.controller.document.isEmpty()) {
      return false;
    }
    final pos = renderEditor!.getPositionForOffset(details.globalPosition);
    final result =
        editor!.widget.controller.document.querySegmentLeafNode(pos.offset);
    final line = result.line;
    if (line == null) {
      return false;
    }
    final segmentLeaf = result.leaf;
    if (segmentLeaf == null && line.length == 1) {
      editor!.widget.controller.updateSelection(
          TextSelection.collapsed(offset: pos.offset), ChangeSource.LOCAL);
      return true;
    }
    return false;
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (_state.widget.onTapDown != null) {
      if (renderEditor != null &&
          _state.widget.onTapDown!(
              details, renderEditor!.getPositionForOffset)) {
        return;
      }
    }
    super.onTapDown(details);
  }

  bool isShiftClick(PointerDeviceKind deviceKind) {
    final pressed = RawKeyboard.instance.keysPressed;
    return deviceKind == PointerDeviceKind.mouse &&
        (pressed.contains(LogicalKeyboardKey.shiftLeft) ||
            pressed.contains(LogicalKeyboardKey.shiftRight));
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    if (_state.widget.onTapUp != null &&
        renderEditor != null &&
        _state.widget.onTapUp!(details, renderEditor!.getPositionForOffset)) {
      return;
    }

    editor!.hideToolbar();

    try {
      if (delegate.selectionEnabled && !_isPositionSelected(details)) {
        final _platform = Theme.of(_state.context).platform;
        if (isAppleOS(_platform) || isDesktop()) {
          // added isDesktop() to enable extend selection in Windows platform
          switch (details.kind) {
            case PointerDeviceKind.mouse:
            case PointerDeviceKind.stylus:
            case PointerDeviceKind.invertedStylus:
              // Precise devices should place the cursor at a precise position.
              // If `Shift` key is pressed then
              // extend current selection instead.
              if (isShiftClick(details.kind)) {
                renderEditor!
                  ..extendSelection(details.globalPosition,
                      cause: SelectionChangedCause.tap)
                  ..onSelectionCompleted();
              } else {
                renderEditor!
                  ..selectPosition(cause: SelectionChangedCause.tap)
                  ..onSelectionCompleted();
              }

              break;
            case PointerDeviceKind.touch:
            case PointerDeviceKind.unknown:
              // On macOS/iOS/iPadOS a touch tap places the cursor at the edge
              // of the word.
              if (_detectWordBoundary) {
                renderEditor!
                  ..selectWordEdge(SelectionChangedCause.tap)
                  ..onSelectionCompleted();
              } else {
                renderEditor!
                  ..selectPosition(cause: SelectionChangedCause.tap)
                  ..onSelectionCompleted();
              }
              break;
            case PointerDeviceKind.trackpad:
              // TODO: Handle this case.
              break;
          }
        } else {
          renderEditor!
            ..selectPosition(cause: SelectionChangedCause.tap)
            ..onSelectionCompleted();
        }
      }
    } finally {
      _state._requestKeyboard();
    }
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (_state.widget.onSingleLongTapStart != null) {
      if (renderEditor != null &&
          _state.widget.onSingleLongTapStart!(
              details, renderEditor!.getPositionForOffset)) {
        return;
      }
    }

    if (delegate.selectionEnabled) {
      final _platform = Theme.of(_state.context).platform;
      if (isAppleOS(_platform)) {
        renderEditor!.selectPositionAt(
          from: details.globalPosition,
          cause: SelectionChangedCause.longPress,
        );
      } else {
        renderEditor!.selectWord(SelectionChangedCause.longPress);
        Feedback.forLongPress(_state.context);
      }
    }
  }

  @override
  void onSingleLongTapEnd(LongPressEndDetails details) {
    if (_state.widget.onSingleLongTapEnd != null) {
      if (renderEditor != null) {
        if (_state.widget.onSingleLongTapEnd!(
            details, renderEditor!.getPositionForOffset)) {
          return;
        }

        if (delegate.selectionEnabled) {
          renderEditor!.onSelectionCompleted();
        }
      }
    }
    super.onSingleLongTapEnd(details);
  }
}
