import 'template/template.dart';

class Util {
  static double pixleToPt(double px) {
    return px * 12700;
  }

  static renderView(
    String templateName,
    String path,
    Map<String, dynamic> variables,
  ) {
    // TODO
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

  static copyMedia(String extractPath, String imagePath) {
    // TODO
  }

  static mergeVariables(
    Map<String, dynamic> b,
    Map<String, dynamic> variables,
  ) {
    // TODO
  }
}
