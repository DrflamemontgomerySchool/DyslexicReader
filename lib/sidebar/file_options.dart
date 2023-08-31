import 'dart:io';

import 'package:dyslexic_reader/file_selector.dart';
import 'package:dyslexic_reader/text_display_page.dart';
import 'package:flutter/material.dart';

class FileOptions {
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
