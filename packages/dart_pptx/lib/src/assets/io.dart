import 'dart:io';
import 'dart:typed_data';

import 'web.dart' as impl;

class Assets extends impl.Assets {
  @override
  Future<Uint8List?> getImageData(String path) async {
    if (hasCache(path)) return getCache(path);
    final file = File(path);
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      setCache(path, bytes);
      return bytes;
    }
    return super.getImageData(path);
  }
}
