import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'dart:ui' as ui;

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
    if (path.startsWith('data:image')) {
      final base64 = path.split(',').last;
      final bytes = base64Decode(base64);
      setCache(path, bytes);
      return bytes;
    }
    try {
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      setCache(path, bytes);
    } catch (e) {
      debugPrint('Failed to load image: $path');
    }
    return null;
  }

  Future<ui.Image?> getImage(String path) async {
    final bytes = await getImageData(path);
    if (bytes == null) return null;
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    return image;
  }

  Future<Size?> getImageSize(String path) async {
    final image = await getImage(path);
    if (image == null) return null;
    return Size(image.width.toDouble(), image.height.toDouble());
  }
}
