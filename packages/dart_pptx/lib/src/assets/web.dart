import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_size_getter/image_size_getter.dart';

class Assets {
  final cache = <String, Uint8List>{};

  bool hasCache(String path) => cache.containsKey(path);
  Uint8List? getCache(String path) => cache[path];
  void setCache(String path, Uint8List bytes) => cache[path] = bytes;
  void removeCache(String path) => cache.remove(path);
  void clearCache() => cache.clear();

  Future<Uint8List?> getImageData(String path) async {
    if (hasCache(path)) return getCache(path);
    if (path.startsWith('http')) {
      final response = await http.get(Uri.parse(path));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        setCache(path, bytes);
        return bytes;
      }
    }
    if (path.startsWith('data:')) {
      final base64 = path.split(',').last;
      final bytes = base64Decode(base64);
      setCache(path, bytes);
      return bytes;
    }
    return null;
  }

  Future<Size?> getImageSize(String path) async {
    final data = await getImageData(path);
    if (data == null) return null;
    return ImageSizeGetter.getSize(MemoryInput(data));
  }
}
