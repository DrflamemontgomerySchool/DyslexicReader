import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:dyslexic_reader/sidebar/file_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static ButtonStyle textButtonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.resolveWith<Size?>(
      (Set<MaterialState> states) {
        return const Size(300, 80);
      },
    ),
  );

  static ButtonStyleButton createTextButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: textButtonStyle,
      child: Text(
        text,
        style: const TextStyle(fontSize: 40),
      ),
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
        columnSizes: [auto, 300.px, auto],
        rowSizes: [auto, 120.px, 120.px, auto],
        children: [
          createTextButton(
            "Open File",
            () => FileOptions.displayIOFile(context),
          ).withGridPlacement(columnStart: 1, rowStart: 1),
          createTextButton(
            "New File",
            () => FileOptions.openNewIOFile(context),
          ).withGridPlacement(columnStart: 1, rowStart: 2),
        ],
      ),
    );
  }
}
