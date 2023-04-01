import 'package:dart_pptx/dart_pptx.dart';
import 'dart:io';

void main() async {
  var pres = PowerPoint();
  pres.addTitleSlide(
    title: TextValue.uniform('Hello World'),
  );
  final bytes = await pres.save();
  if (bytes != null) {
    File('./hello.pptx').writeAsBytesSync(bytes);
  } else {
    print('Failed to save presentation');
  }
}
