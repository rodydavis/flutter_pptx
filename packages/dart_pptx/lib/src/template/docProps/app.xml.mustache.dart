/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/docProps/app.xml.mustache
const String template =
    r'''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
    xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
    <TotalTime>0</TotalTime>
    <Words>43</Words>
    <Application>Microsoft Macintosh PowerPoint</Application>
    <PresentationFormat>On-screen Show (4:3)</PresentationFormat>
    <Paragraphs>15</Paragraphs>
    <Slides>{{length}}</Slides>
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
                <vt:i4>{{length}}</vt:i4>
            </vt:variant>
        </vt:vector>
    </HeadingPairs>
    <TitlesOfParts>
        <vt:vector size="{{size}}" baseType="lpstr">
            <vt:lpstr>Arial</vt:lpstr>
            <vt:lpstr>Calibri</vt:lpstr>
            <vt:lpstr>Office Theme</vt:lpstr>
            {{#slides}}
            <vt:lpstr>{{name}}</vt:lpstr>
            {{/slides}}
        </vt:vector>
    </TitlesOfParts>
    {{#company}}
    <Company>{{.}}</Company>
    {{/company}}
    <LinksUpToDate>false</LinksUpToDate>
    <SharedDoc>false</SharedDoc>
    <HyperlinksChanged>false</HyperlinksChanged>
    <AppVersion>15.0000</AppVersion>
</Properties>''';
