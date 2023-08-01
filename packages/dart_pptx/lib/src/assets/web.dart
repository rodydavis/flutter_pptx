// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:image_size_getter/image_size_getter.dart';

import '../classes/images.dart';

class Assets {
  http.Client client = RetryClient(http.Client());
  final cache = <ImageReference>[];

  bool hasCache(ImageReference img) {
    return cache.contains(img) &&
        cache.firstWhere((e) => e == img).bytes != null;
  }

  Uint8List? getCache(ImageReference img) {
    return cache.firstWhere((e) => e == img).bytes;
  }

  void setCache(ImageReference img, Uint8List bytes) {
    if (!hasCache(img)) {
      img.bytes = bytes;
      cache.add(img);
    } else {
      cache.firstWhere((e) => e == img).bytes = bytes;
    }
  }

  void removeCache(ImageReference img) {
    cache.removeWhere((e) => e == img);
  }

  void clearCache() {
    cache.clear();
  }

  Future<Uint8List?> getImageData(ImageReference img) async {
    final path = img.path;
    if (hasCache(img)) return getCache(img);
    if (img.bytes != null) {
      setCache(img, img.bytes!);
      return img.bytes;
    }
    if (path.startsWith('http')) {
      final response = await client.get(Uri.parse(path));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        setCache(img, bytes);
        return bytes;
      }
    }
    if (path.startsWith('data:')) {
      final base64 = path.split(',').last;
      final bytes = base64Decode(base64);
      setCache(img, bytes);
      return bytes;
    }
    print('Failed to get image data: $path');
    return null;
  }

  Future<Size?> getImageSize(ImageReference img) async {
    final data = await getImageData(img);
    if (data == null) return null;
    return ImageSizeGetter.getSize(MemoryInput(data));
  }
}
