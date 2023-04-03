/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/ppt/commentAuthors.xml
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<p:cmAuthorLst xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main">
    {{#authors}}
    <p:cmAuthor id="{{id}}" name="{{name}}" initials="{{initials}}" lastIdx="{{lastIdx}}" clrIdx="{{clrIdx}}"/>
    {{/authors}}
</p:cmAuthorLst>''';
