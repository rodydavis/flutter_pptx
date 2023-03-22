import 'package:flutter_pptx/src/views/presentation.xml.rel.dart' as xml;
import 'package:flutter_test/flutter_test.dart';

const template = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Target="slideMasters/slideMaster1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"/>
  <Relationship Id="rId2" Target="presProps.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps"/>
  <Relationship Id="rId3" Target="viewProps.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/viewProps"/>
  <Relationship Id="rId4" Target="theme/theme1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"/>
  <Relationship Id="rId5" Target="tableStyles.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/tableStyles"/>
  <Relationship Id="rId7" Target="slides/slide2.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"/>
  <Relationship Id="rId8" Target="slides/slide3.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"/>
</Relationships>
''';

void main() {
  test('check presentation.xml.rel template', () {
    final source = xml.Source(
      slides: [
        xml.Slide.fromIndex(1),
        xml.Slide.fromIndex(2),
      ],
    );

    final result = xml.renderString(source);

    expect(result, isNotEmpty);
    expect(result, equals(template));
  });
}
