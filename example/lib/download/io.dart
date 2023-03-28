import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

Future<void> downloadFile(String name, Uint8List bytes) async {
  Share.shareXFiles(
    [
      XFile.fromData(
        bytes,
        name: 'presentation.pptx',
        mimeType:
            'application/vnd.openxmlformats-officedocument.presentationml.presentation',
        lastModified: DateTime.now(),
        length: bytes.length,
      )
    ],
    text: 'Presentation',
  );
}
