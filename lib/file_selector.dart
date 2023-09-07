import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;
import 'package:flutter/material.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({
    super.key,
    required this.onSelect,
    required this.path,
    required this.selectingNewFile,
  });

  final Function(String?) onSelect;
  final String path;
  final bool selectingNewFile;

  static void selectFileMobile(
    BuildContext context,
    Function(String?) onSelect,
    bool selectingNewFile,
  ) {
    Future<Directory> dir = pp.getApplicationDocumentsDirectory();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FutureBuilder(
          future: dir,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return FileSelector(
                onSelect: onSelect,
                path: (snapshot.data as Directory).path,
                selectingNewFile: selectingNewFile,
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text("Getting Directory"),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  static void selectFilePC(
    BuildContext context,
    Function(String?) onSelect,
    bool selectingNewFile,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FileSelector(
          onSelect: onSelect,
          path: Directory.current.path,
          selectingNewFile: selectingNewFile,
        ),
      ),
    );
  }

  static void selectFile(
    BuildContext context,
    Function(String?) onSelect,
    bool selectingNewFile,
  ) {
    if (Platform.isAndroid || Platform.isIOS) {
      selectFileMobile(context, onSelect, selectingNewFile);
    } else {
      selectFilePC(context, onSelect, selectingNewFile);
    }
  }

  void warnOverwrite(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "File.txt");
    ValueNotifier<String> pathNotifier = ValueNotifier<String>(path);
    return Scaffold(
      appBar: AppBar(
          leading: Row(
            children: [
              TextButton(
                onPressed: () {
                  pathNotifier.value = p.dirname(pathNotifier.value);
                },
                child: const Text(
                  "Prev",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ],
          ),
          title: ValueListenableBuilder(
            valueListenable: pathNotifier,
            builder: (BuildContext context, String value, Widget? child) =>
                Text(
              p.basename(value),
            ),
          )),
      body: ValueListenableBuilder(
        builder: (BuildContext context, path, Widget? child) {
          Directory currentDirectory = Directory(path);
          List<FileSystemEntity> directoryList = currentDirectory.listSync();

          List<String> folders = [];
          List<String> documents = [];

          for (FileSystemEntity file in directoryList) {
            if (file is Directory) {
              folders.add(file.path);
            } else if (file is File && p.extension(file.path) == '.txt') {
              documents.add(file.path);
            }
          }

          List<Widget> selections = [];
          selections.addAll([
            for (String folder in folders)
              GestureDetector(
                onDoubleTap: () {
                  pathNotifier.value = folder;
                },
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.folder),
                        Text(p.basename(folder)),
                      ],
                    ),
                  ),
                ),
              ),
          ]);
          selections.addAll([
            for (String document in documents)
              GestureDetector(
                onDoubleTap: () => alertDialog(
                  context,
                  p.basename(document),
                  document,
                ),
                onTap: () {
                  controller.text = p.basename(document);
                },
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file_sharp),
                        Text(
                          p.basename(document),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ]);
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (BuildContext context, int index) =>
                  selections[index],
              itemCount: selections.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 2.0),
            ),
          );
        },
        valueListenable: pathNotifier,
      ),
      persistentFooterButtons: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "File Name",
            constraints: BoxConstraints.tightFor(width: 320),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSelect(null);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => alertDialog(
            context,
            controller.text,
            '${pathNotifier.value}/${controller.text}',
          ),
          child: const Text("Open"),
        )
      ],
    );
  }

  void alertDialog(BuildContext context, String fileName, String filePath) {
    File selectedFile = File(filePath);
    if (selectingNewFile && selectedFile.existsSync()) {
      showAlertDialog(
        context,
        titleText: 'File "$fileName" Already Exists',
        message: "Are you sure that you want to overwrite the file",
        buttons: {
          "Cancel": null,
          "Overwrite": () {
            Navigator.pop(context);
            onSelect(fileName);
          },
        },
      );
    } else if (!selectingNewFile && !selectedFile.existsSync()) {
      showAlertDialog(
        context,
        titleText: 'File "$fileName" Doesn\'t Exist',
        buttons: {
          "OK": () => null,
        },
      );
    } else {
      Navigator.pop(context);
      onSelect(filePath);
    }
  }

  void showAlertDialog(
    BuildContext context, {
    required String titleText,
    String? message,
    required Map<String, Function()?> buttons,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titleText),
        content: message == null ? null : Text(message),
        actions: [
          for (String text in buttons.keys)
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (buttons[text] != null) buttons[text]!();
                },
                child: Text(text)),
        ],
      ),
    );
  }
}
