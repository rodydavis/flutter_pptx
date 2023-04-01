import 'package:dart_pptx/dart_pptx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterAssets extends Assets {
  @override
  Future<Uint8List?> getImageData(String path) async {
    if (hasCache(path)) return getCache(path);
    try {
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      setCache(path, bytes);
      return bytes;
    } catch (e) {
      debugPrint('Failed to load image: $path');
    }
    return super.getImageData(path);
  }
}
