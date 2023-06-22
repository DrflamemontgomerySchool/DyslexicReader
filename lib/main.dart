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
        primarySwatch: Colors.grey,
      ),
      home: const SideMenuTest(),
    );
  }
}
