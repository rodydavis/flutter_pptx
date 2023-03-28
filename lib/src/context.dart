// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:screenshot/screenshot.dart';

import 'assets/assets.dart';
import 'compression.dart';

class PresentationContext {
  var archive = Compression();
  var assets = Assets();
  var screenshotController = ScreenshotController();
}
