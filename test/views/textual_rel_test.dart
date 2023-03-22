import 'package:flutter_pptx/src/views/textual_rel.xml.dart' as xml;
import 'package:flutter_test/flutter_test.dart';

const template = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Target="../slideLayouts/slideLayout1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
</Relationships>
''';

void main() {
  test('check textual_rel.xml template', () {
    final source = xml.Source(
      index: 1,
    );

    final result = xml.renderString(source);

    expect(result, isNotEmpty);
    expect(result, equals(template));
  });
}
