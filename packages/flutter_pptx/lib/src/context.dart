import 'package:dart_pptx/dart_pptx.dart';
import 'package:screenshot/screenshot.dart';

import 'assets.dart';

class FlutterPresentationContext extends PresentationContext {
  var screenshotController = ScreenshotController();

  @override
  // ignore: overridden_fields
  var assets = FlutterAssets();
}
