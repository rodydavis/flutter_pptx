import 'dart:io';

Future<void> savePptx(String path, List<int> bytes) async {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }
  file.writeAsBytesSync(bytes);
}
