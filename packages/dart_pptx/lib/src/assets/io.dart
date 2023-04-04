import 'dart:io';
import 'dart:typed_data';

import '../classes/images.dart';
import 'web.dart' as impl;

class Assets extends impl.Assets {
  @override
  Future<Uint8List?> getImageData(ImageReference img) async {
    final path = img.path;
    if (hasCache(img)) return getCache(img);
    final file = File(path);
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      setCache(img, bytes);
      return bytes;
    }
    return super.getImageData(img);
  }
}
