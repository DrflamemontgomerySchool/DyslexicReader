import 'dart:io';

import 'package:dyslexic_reader/file_selector.dart';
import 'package:dyslexic_reader/text_display_page.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class FileOptions {
  static MaterialPageRoute newFile(String file) {
    return MaterialPageRoute(
      builder: (ctx) => TextDisplayPage(
        fileName: file,
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

  static void displayIOFile(BuildContext context) {
    FileSelector.selectFile(
      context,
      (name) {
        if (name == null) return;
        File file = File(name);

        Navigator.pop(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TextDisplayPage(
              fileName: name,
              text: file.readAsStringSync(),
            ),
          ),
        );
      },
      false,
    );
  }

  static void openNewIOFile(BuildContext context) {
    FileSelector.selectFile(
      context,
      (name) {
        if (name == null) return;
        Navigator.pop(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TextDisplayPage(
              fileName: name,
            ),
          ),
        );
      },
      true,
    );
  }

  static Widget createFileOpenWidget() {
    return const Placeholder();
  }
}
