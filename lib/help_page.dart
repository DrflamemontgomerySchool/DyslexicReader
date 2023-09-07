import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static void displayHelp(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const HelpPage();
      },
    );
  }

  static Widget createHelpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () => HelpPage.displayHelp(context),
        icon: const Icon(Icons.help),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PageView(
          children: [
            Column(
              children: [
                Text(
                  "How To Use The Dyslexic Reader",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Text("There are four buttons on the "),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
