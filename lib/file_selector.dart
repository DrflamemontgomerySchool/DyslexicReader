import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

class FileSelector extends StatelessWidget {
  const FileSelector(
      {super.key,
      required this.onSelect,
      required this.path,
      required this.warnOnOverwrite});

  final Function(String?) onSelect;
  final String path;
  final bool warnOnOverwrite;

  static void selectFile(
      BuildContext context, Function(String?) onSelect, bool warnOnOverwrite) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FileSelector(
          onSelect: onSelect,
          path: Directory.current.path,
          warnOnOverwrite: warnOnOverwrite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: "File.txt");
    ValueNotifier<String> pathNotifier = ValueNotifier<String>(path);
    List<String> fileNames = [];
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
                onDoubleTap: () {
                  Navigator.pop(context);
                  onSelect(document);
                },
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
          onPressed: () {
            Navigator.pop(context);
            if (fileNames.contains(controller.text)) {
              print('${controller.text} exists');
            } else {
              onSelect('${pathNotifier.value}/${controller.text}');
            }
          },
          child: const Text("Open"),
        )
      ],
    );
  }
}

class _MoveBackIntent extends Intent {
  const _MoveBackIntent();
}
