import 'package:dyslexic_reader/home_page.dart';
import 'package:dyslexic_reader/sidebar/file_options.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

/*
 * The App side menu contains the file options
 */
class AppSideMenu extends StatelessWidget {
  const AppSideMenu({super.key, this.onSave});

  static Future<XFile?> browseAndOpenFile() async {
    XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[
      const XTypeGroup(label: 'documents', extensions: <String>['txt'])
    ]);
    return file;
  }

  final Function(bool)? onSave;

  static void openText(XFile? file, BuildContext context) {
    //Navigator.pop(context);
    //FileOptions.displayFile(file, context);
  }

  @override
  Widget build(BuildContext context) {
    List<ListTile> optionButtons = [
      ListTile(
        leading: const Icon(
          Icons.other_houses_sharp,
        ),
        title: const Text('Home'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => const HomePage(),
          ));
        },
      ),
      ListTile(
          leading: const Icon(
            Icons.file_open,
          ),
          title: const Text('Open File'),
          onTap: () async {
            XFile? file = await browseAndOpenFile();
            if (file == null) return;
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push(await FileOptions.displayFile(file!));
          }),
      ListTile(
          leading: const Icon(
            Icons.note_add,
          ),
          title: const Text('New File'),
          onTap: () async {
            String? outputFile = await FilePicker.platform.saveFile(
              dialogTitle: 'Please select an output file:',
              fileName: 'output-file.txt',
            );
            if (outputFile == null) return;
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.of(context).push(FileOptions.newFile(outputFile));
            print(outputFile);
            //openText(null, context);
            //XFile? file = await browseAndOpenFile();
          }),
    ];
    if (onSave != null) {
      optionButtons.addAll(
        [
          ListTile(
            leading: const Icon(
              Icons.save,
            ),
            title: const Text("Save File"),
            onTap: () {
              onSave!(false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.save_as,
            ),
            title: const Text("Save as File"),
            onTap: () async {
              onSave!(true);
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: optionButtons,
      ),
    );
  }
}
