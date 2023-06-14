import 'package:dyslexic_reader/app_side_menu.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SideMenuTest extends StatelessWidget {
  SideMenuTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Navigation Drawer'),
        backgroundColor: const Color(0xff764abc),
      ),
      drawer: const AppSideMenu(),
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
