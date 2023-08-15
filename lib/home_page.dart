import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:dyslexic_reader/sidebar/file_options.dart';
import 'package:dyslexic_reader/text_display_page.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static ButtonStyle textButtonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.resolveWith<Size?>(
      (Set<MaterialState> states) {
        return const Size(100, 40);
      },
    ),
  );

  static ButtonStyleButton createTextButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: textButtonStyle,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppSideMenu(),
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: LayoutGrid(
        columnSizes: [auto, 160.px, 160.px, auto],
        rowSizes: [auto, 60.px, 60.px, auto],
        children: [
          createTextButton("Open File", () async {
            XFile? file = await AppSideMenu.browseAndOpenFile();
            if (file == null) return;
            Navigator.pop(context);
            Navigator.of(context).push(await FileOptions.displayFile(file!));
          }).withGridPlacement(columnStart: 1, rowStart: 1),
          createTextButton("New File", () async {
            String? outputFile = await FilePicker.platform.saveFile(
              dialogTitle: 'Please select an output file:',
              fileName: 'output-file.txt',
            );
            if (outputFile == null) return;
            Navigator.pop(context);
            Navigator.of(context).push(FileOptions.newFile(outputFile));
            print(outputFile);
          }).withGridPlacement(columnStart: 1, rowStart: 2),
          createTextButton("Settings", () => null)
              .withGridPlacement(columnStart: 2, rowStart: 1),
        ],
      ),
    );
  }
}
