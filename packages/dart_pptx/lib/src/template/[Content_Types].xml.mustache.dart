/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/[Content_Types].xml.mustache
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
    <Default Extension="xml" ContentType="application/xml"/>
    <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
    <Default Extension="jpeg" ContentType="image/jpg"/>
    <Default Extension="png" ContentType="image/png"/>
    <Default Extension="bmp" ContentType="image/bmp"/>
    <Default Extension="gif" ContentType="image/gif"/>
    <Default Extension="tif" ContentType="image/tif"/>
    <Default Extension="pdf" ContentType="application/pdf"/>
    <Default Extension="mov" ContentType="application/movie"/>
    <Default Extension="vml" ContentType="application/vnd.openxmlformats-officedocument.vmlDrawing"/>
    <Default Extension="xlsx" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
    <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
    <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
    <Override PartName="/ppt/presentation.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"/>
    <Override PartName="/ppt/presProps.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.presProps+xml"/>
    <Override PartName="/ppt/viewProps.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.viewProps+xml"/>
    <Override PartName="/ppt/commentAuthors.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.commentAuthors+xml"/>
    <Override PartName="/ppt/tableStyles.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.tableStyles+xml"/>
    <Override PartName="/ppt/slideMasters/slideMaster1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"/>
    <Override PartName="/ppt/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
    <Override PartName="/ppt/notesMasters/notesMaster1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.notesMaster+xml"/>
    <Override PartName="/ppt/theme/theme2.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
    {{#slides}}
    <Override PartName="/ppt/slides/slide{{order}}.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml"/>
    {{/slides}}
    {{#notes}}
    <Override PartName="/ppt/notesSlides/notesSlide{{order}}.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml"/>
    {{/notes}}
    {{#comments}}
    <Override PartName="/ppt/comments/comment{{order}}.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.comments+xml"/>
    {{/comments}}
</Types>''';
