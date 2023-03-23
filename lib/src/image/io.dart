import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';

import 'dart:ui' as ui;
import 'package:path/path.dart' as path;

import '../compression.dart';

class ImageLibrary {
  final cache = <String, ui.Image>{};

  ImageProvider getImageProvider(String imagePath) {
    if (imagePath.startsWith('data:image')) {
      return MemoryImage(base64Decode(imagePath));
    } else if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }

  Future<ui.Image> getImage(String imagePath) async {
    if (cache.containsKey(imagePath)) {
      return cache[imagePath]!;
    }
    final file = File(imagePath);
    if (file.existsSync()) {
      final bytes = file.readAsBytesSync();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      cache[imagePath] = image;
      return image;
    } else {
      final provider = getImageProvider(imagePath);
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
  }

  Future<Size> getImageSize(String imagePath) async {
    final image = await getImage(imagePath);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  Future<void> copyMedia(String imagePath, Compression archive) async {
    final file = File(imagePath);
    if (file.existsSync()) {
      final bytes = file.readAsBytesSync();
      final fileName = path.basename(imagePath);
      archive.addBinaryFile('ppt/media/$fileName', bytes);
    } else {
      final image = await getImage(imagePath);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final buffer = bytes!.buffer;
      final data = buffer.asUint8List();
      final fileName = path.basename(imagePath);
      archive.addBinaryFile('ppt/media/$fileName', data);
    }
  }
}
