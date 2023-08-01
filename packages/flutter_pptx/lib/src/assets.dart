import 'package:dart_pptx/dart_pptx.dart';
import 'package:flutter/services.dart';

class FlutterAssets extends Assets {
  @override
  Future<Uint8List?> getImageData(ImageReference img) async {
    final path = img.path;
    if (hasCache(img)) return getCache(img);
    try {
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      setCache(img, bytes);
      return bytes;
    } catch (e) {
      // debugPrint('Failed to load image: $path');
    }
    return super.getImageData(img);
  }
}
