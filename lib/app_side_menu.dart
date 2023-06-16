import 'package:dyslexic_reader/sidebar/file_options.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

/*
 * The App side menu contains the file options
 */
class AppSideMenu extends StatelessWidget {
  const AppSideMenu({super.key});

  Future<XFile?> browseAndOpenFile() async {
    XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[
      const XTypeGroup(label: 'documents', extensions: <String>['txt'])
    ]);
    return file;
  }

  void openText(XFile? file, BuildContext context) {
    Navigator.pop(context);
    FileOptions.displayFile(file, context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: const Icon(
              Icons.train, // Placeholder
            ),
            title: const Text('Open File'),
            onTap: () async => openText(await browseAndOpenFile(), context),
          )
        ],
      ),
    );
  }
}
