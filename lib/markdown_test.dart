import 'package:dyslexic_reader/style_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

class MarkdownTest extends StatelessWidget {
  const MarkdownTest({
    super.key,
    required this.data,
    required this.rules,
    this.seed,
  });

  final String data;
  final StyleRules rules;
  final int? seed;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: data,
      inlineSyntaxes: [TestExtension()],
      builders: {
        "styleRule": TestExtensionBuilder(
            context: context, rules: rules, seed: seed ?? hashCode)
      },
    );
  }
}

class TestExtension extends md.InlineSyntax {
  TestExtension() : super(r'''([^ \t\n\r]+)\w*''');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    md.Element styledTag =
        md.Element.text('styleRule', match.group(1) ?? 'matched text');
    print('group 1: ${match.group(1)}');
    parser.addNode(styledTag);
    return true;
  }
}

class TestExtensionBuilder extends MarkdownElementBuilder {
  TestExtensionBuilder({required this.context, required this.rules, this.seed});
  final BuildContext context;
  final StyleRules rules;
  final int? seed;

  late final styles = StyleGenerator(
    seed: seed ?? hashCode,
    rules: rules,
  );

  @override
  Widget visitElementAfter(element, preferredStyle) {
    return MarkdownBody(
      styleSheet: MarkdownStyleSheet.fromTheme(
        ThemeData(
          textTheme: TextTheme(
            bodyText2: styles.getNextStyle(),
          ),
        ),
      ),
      data: element.textContent,
    );
  }
}
