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

  @override
  Widget build(BuildContext context) {
    return TextDisplayPage(
      fileName: "",
      isStatic: true,
      text: """How To Use The Dyslexic Reading Application:



The Dyslexic Reading Program Has FOUR buttons at the top of the page.
Click any button to turn the font effect OFF or ON.



What Do All The Buttons Do?



- The "Bold" checkbox enables the font effect that bolds the text
- The "Normal" checkbox enables the font effect that removes bold from text
      ("Normal" has no effect when Bold is disabled)

When these two effects are enabled, the font effect toggles between bold and not bold

- The "Change Size" checkbox enables the font size to change for every word
- The "Change Fonts" checkbox enables the font style to change for every word

Try Clicking All The Checkboxes To See The Effects



How to use the File Browser



The File Browser opens when "Open File", "New File", or "Save as File" is pressed 

The Top Bar of the File Browser has a button named "Prev" which opens the folder that contains the current folder
The File Browser has the name of the current folder next to the button "Prev"

The Bottom Bar has a Text Field for the File Name.
Next to the Text Field is two buttons.
The "Cancel" button exits the File Browser
The "Open" button selects the Current File to be opened, created, or saved

The content of the File Browser shows the text files and folders inside the current folder
You can double click a folder to enter that folder
You can double click a file to open that file

Single clicking a file will set the File Name text field to the name of the clicked file
""",
    );
  }
}
