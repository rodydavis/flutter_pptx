/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/docProps/core.xml.mustache
const String template =
    r'''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dcmitype="http://purl.org/dc/dcmitype/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	{{#title}}
	<dc:title>{{.}}</dc:title>
	{{/title}}
	{{#subject}}
	<dc:subject>{{.}}</dc:subject>
	{{/subject}}
	{{#author}}
	<dc:creator>{{.}}</dc:creator>
	<cp:lastModifiedBy>{{.}}</cp:lastModifiedBy>
	{{/author}}
	{{#revision}}
	<cp:revision>{{.}}</cp:revision>
	{{/revision}}
	{{#date}}
	<dcterms:created xsi:type="dcterms:W3CDTF">{{.}}</dcterms:created>
	<dcterms:modified xsi:type="dcterms:W3CDTF">{{.}}</dcterms:modified>
	{{/date}}
</cp:coreProperties>''';
