import 'package:dyslexic_reader/text_display_page.dart';
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

  TextStyle? _headlineStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge;
  TextStyle? _bodyStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;

  @override
  Widget build(BuildContext context) {
    return TextDisplayPage(
      fileName: "",
      isStatic: true,
      text: """How To Use The Dyslexic Reading Application:

The Dyslexic Reading Program Has FOUR buttons at the top of the page.
Click any button to turn the font effect OFF or ON.


What Do All The Buttons Do?


- The "Bold" button enables the font effect that bolds the text
- The "Normal" button enables the font effect that removes bold from text

When these two effects are enabled, the font effect toggles between bold and not bold

- The "Change Size" button

""",
    );
  }
}
