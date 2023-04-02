import 'dart:convert';

String getXml(List<int> bytes) {
  return utf8.decode(bytes);
}

String? maybeGetXml(List<int>? bytes) {
  if (bytes == null) return null;
  return getXml(bytes);
}
