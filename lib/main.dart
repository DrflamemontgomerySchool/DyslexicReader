import 'package:dyslexic_reader/home_page.dart';
import 'package:dyslexic_reader/side_menu_test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DyslexicReader());
}

class DyslexicReader extends StatelessWidget {
  const DyslexicReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyslexic Reader',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        canvasColor: const Color.fromARGB(255, 228, 202, 173),
      ),

      //home: const SideMenuTest(),
      home: const HomePage(),
    );
  }
}
