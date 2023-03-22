import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

void main() {
  test('check presentation', () {
    final pres = Powerpoint();

    expect(pres.runtimeType, Powerpoint);
  });
}
