// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

Future<void> downloadFile(String name, Uint8List bytes) async {
  final blob = html.Blob([bytes], 'application/octet-stream');
  final url = html.Url.createObjectUrlFromBlob(blob);
  // ignore: unused_local_variable
  final link = html.AnchorElement()
    ..href = url
    ..download = name
    ..click();
  html.Url.revokeObjectUrl(url);
}
