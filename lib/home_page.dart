import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static ButtonStyle textButtonStyle = ButtonStyle(
    fixedSize: MaterialStateProperty.resolveWith<Size?>(
      (Set<MaterialState> states) {
        return const Size(100, 40);
      },
    ),
  );

  ButtonStyleButton _createTextButton(String text, Function() onPressed) {
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
          _createTextButton("Open File", () => null)
              .withGridPlacement(columnStart: 1, rowStart: 1),
          _createTextButton("New File", () => null)
              .withGridPlacement(columnStart: 1, rowStart: 2),
          _createTextButton("Settings", () => null)
              .withGridPlacement(columnStart: 2, rowStart: 1),
        ],
      ),
    );
  }
}
