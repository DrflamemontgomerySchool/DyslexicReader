import 'package:dyslexic_reader/text_display_page.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class FileOptions {
  static void newFile(XFile file, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TextDisplayPage(
          fileName: file.path,
        ),
      ),
    );
  }

  static Future<MaterialPageRoute> displayFile(XFile file) async {
    String fileData = await file.readAsString();

    return MaterialPageRoute(
      builder: (ctx) => TextDisplayPage(
        fileName: file.path,
        text: fileData,
      ),
    );
  }

  static Widget createFileOpenWidget() {
    return const Placeholder();
  }
}
