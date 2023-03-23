import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'compression.dart';

class ImageLibrary {
  final cache = <String, ui.Image>{};

  Future<ui.Image> getImage(String imagePath) async {
    final provider = getImageProvider(imagePath);
    if (cache.containsKey(provider)) {
      return cache[provider]!;
    }
    final completer = Completer<ui.Image>();
    const config = ImageConfiguration();
    provider.resolve(config).addListener(
          ImageStreamListener(
            (info, bool _) => completer.complete(
              info.image,
            ),
            onError: (exception, stackTrace) => completer.completeError(
              exception,
              stackTrace,
            ),
          ),
        );
    final result = await completer.future;
    cache[imagePath] = result;
    return result;
  }

  Future<Size> getImageSize(String imagePath) async {
    final image = await getImage(imagePath);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  ImageProvider getImageProvider(String imagePath) {
    if (imagePath.startsWith('data:image')) {
      return MemoryImage(base64Decode(imagePath));
    } else if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }

  Future<void> copyMedia(String imagePath, Compression archive) async {
    final image = await getImage(imagePath);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = bytes!.buffer;
    final data = buffer.asUint8List();
    final fileName = path.basename(imagePath);
    archive.addBinaryFile('ppt/media/$fileName', data);
  }
}
