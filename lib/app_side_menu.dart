import 'package:dyslexic_reader/home_page.dart';
import 'package:dyslexic_reader/sidebar/file_options.dart';
import 'package:flutter/material.dart';

/*
 * The App side menu contains the file options
 */
class AppSideMenu extends StatelessWidget {
  const AppSideMenu({super.key, this.onSave});

  final Function(bool)? onSave;

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
          onTap: () {
            Navigator.pop(context);
            FileOptions.displayIOFile(context);
          }),
      ListTile(
          leading: const Icon(
            Icons.note_add,
          ),
          title: const Text('New File'),
          onTap: () {
            Navigator.pop(context);
            FileOptions.openNewIOFile(context);
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
              Navigator.pop(context);
              onSave!(false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.save_as,
            ),
            title: const Text("Save as File"),
            onTap: () {
              Navigator.pop(context);
              onSave!(true);
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
