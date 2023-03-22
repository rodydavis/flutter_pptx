import 'package:flutter_pptx/views/app.xml.dart' as xml;
import 'package:flutter_test/flutter_test.dart';

const template = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
            xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <TotalTime>0</TotalTime>
  <Words>43</Words>
  <Application>Microsoft Macintosh PowerPoint</Application>
  <PresentationFormat>On-screen Show (4:3)</PresentationFormat>
  <Paragraphs>15</Paragraphs>
  <Slides>3</Slides>
  <Notes>0</Notes>
  <HiddenSlides>0</HiddenSlides>
  <MMClips>0</MMClips>
  <ScaleCrop>false</ScaleCrop>
  <HeadingPairs>
    <vt:vector size="6" baseType="variant">
      <vt:variant>
        <vt:lpstr>Fonts Used</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>2</vt:i4>
      </vt:variant>
      <vt:variant>
        <vt:lpstr>Theme</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>1</vt:i4>
      </vt:variant>
      <vt:variant>
        <vt:lpstr>Slide Titles</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>3</vt:i4>
      </vt:variant>
    </vt:vector>
  </HeadingPairs>
  <TitlesOfParts>
    <vt:vector size="6" baseType="lpstr">
      <vt:lpstr>Arial</vt:lpstr>
      <vt:lpstr>Calibri</vt:lpstr>
      <vt:lpstr>Office Theme</vt:lpstr>
      <vt:lpstr>Slide 1</vt:lpstr>
      <vt:lpstr>Slide 2</vt:lpstr>
      <vt:lpstr>Slide 3</vt:lpstr>
    </vt:vector>
  </TitlesOfParts>
  <Company></Company>
  <LinksUpToDate>false</LinksUpToDate>
  <SharedDoc>false</SharedDoc>
  <HyperlinksChanged>false</HyperlinksChanged>
  <AppVersion>15.0000</AppVersion>
</Properties>
''';

void main() {
  test('check app.xml template', () {
    final source = xml.Source(slides: [
      xml.Slide(title: 'Slide 1'),
      xml.Slide(title: 'Slide 2'),
      xml.Slide(title: 'Slide 3'),
    ]);

    final result = xml.renderString(source);

    expect(result, isNotEmpty);
    expect(result, equals(template));
  });
}
