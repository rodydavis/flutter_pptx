import 'template/template.dart';

class Util {
  static double pixleToPt(double px) {
    return px * 12700;
  }

  static double ptToPixle(num pt) {
    return pt / 12700;
  }

  static readTemplate(String filename) {
    return templates[filename];
  }

  static requireArguments(
    List<String> requiredArgements,
    Map<String, dynamic> argements,
  ) {
    for (final requiredKey in requiredArgements) {
      if (!argements.keys.contains(requiredKey)) {
        throw ArgumentError();
      }
    }
    return true;
  }
}
