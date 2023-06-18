import 'package:dyslexic_reader/text_display_page.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

class FileOptions {
  static void displayFile(XFile? file, BuildContext context) {
    if (file == null) return;
    Future<String> fileData = file.readAsString();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FutureBuilder<String>(
            future: fileData,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return TextDisplayPage(text: snapshot.data!);
              }
              return const Text("Loading");
            }),
      ),
    );
  }

  static Widget createFileOpenWidget() {
    return const Placeholder();
  }
}
