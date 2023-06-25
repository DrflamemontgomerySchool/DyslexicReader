import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static ButtonStyle textButtonStyle = ButtonStyle(
    minimumSize: MaterialStateProperty.resolveWith<Size?>(
      (Set<MaterialState> states) {
        return const Size(60, 40);
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _createTextButton("Open File", () => null),
                    const Text(""),
                    _createTextButton("New File", () => null),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createTextButton("Settings", () => null),
                const Text(
                    "\n\n"), // To keep the formatting inline with the other side
              ],
            ),
          ),
        ],
      ),
    );
  }
}
