import 'package:flutter_pptx/views/content_type.xml.dart' as xml;
import 'package:flutter_test/flutter_test.dart';

const template = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default ContentType="application/xml" Extension="xml"/>
  <Default ContentType="application/vnd.openxmlformats-package.relationships+xml" Extension="rels"/>
  <Default ContentType="image/png" Extension="png"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml" PartName="/ppt/presentation.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml" PartName="/ppt/slideMasters/slideMaster1.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml" PartName="/ppt/slides/slide1.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml" PartName="/ppt/slides/slide2.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml" PartName="/ppt/slides/slide3.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.presProps+xml" PartName="/ppt/presProps.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.viewProps+xml" PartName="/ppt/viewProps.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.theme+xml" PartName="/ppt/theme/theme1.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.tableStyles+xml" PartName="/ppt/tableStyles.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout1.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout2.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout3.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout4.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout5.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout6.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout7.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout8.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout9.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout10.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml" PartName="/ppt/slideLayouts/slideLayout11.xml"/>
  <Override ContentType="application/vnd.openxmlformats-package.core-properties+xml" PartName="/docProps/core.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml" PartName="/docProps/app.xml"/>
</Types>
''';

void main() {
  test('check content_type.xml template', () {
    final source = xml.Source(
      fileTypes: [
        xml.FileType(type: 'png'),
      ],
      slides: [
        xml.Slide(order: 1),
        xml.Slide(order: 2),
        xml.Slide(order: 3),
      ],
    );

    final result = xml.renderString(source);

    expect(result, isNotEmpty);
    expect(result, equals(template));
  });
}
