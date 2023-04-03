/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/ppt/slides/_rels/slide.xml.rels.mustache
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout{{layoutId}}.xml"/>
    {{#notes}}
    <Relationship Id="rId{{localRId}}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesSlide" Target="../notesSlides/notesSlide{{order}}.xml"/>
    {{/notes}}
    {{#images}}
    <Relationship Id="rId{{localRId}}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="../media/image{{order}}.{{ext}}"/>
    {{/images}}
    {{#comments}}
    <Relationship Id="rId{{localRId}}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/comments" Target="../comments/comment{{order}}.xml"/>
    {{/comments}}
</Relationships>''';
