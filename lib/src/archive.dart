import 'package:archive/archive.dart';

class Archive {
  ZipEncoder encoder = ZipEncoder();

  reset() {
    encoder = ZipEncoder();
  }

  saveFile(String path, String source) {
    final file = ArchiveFile.string(path, source);
    encoder.addFile(file);
  }
}
