import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'content_type.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml" PartName="/ppt/presentation.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml" PartName="/ppt/slideMasters/slideMaster1.xml"/>
  {{#slides}}
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml" PartName="/ppt/slides/slide{{order}}.xml"/>
  {{/slides}}
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.presProps+xml" PartName="/ppt/presProps.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.viewProps+xml" PartName="/ppt/viewProps.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.theme+xml" PartName="/ppt/theme/theme1.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.tableStyles+xml" PartName="/ppt/tableStyles.xml"/>
  <Override ContentType="application/vnd.openxmlformats-officedocument.presentationml.notesMaster+xml" PartName="/ppt/notesMasters/notesMaster1.xml"/>
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

@JsonSerializable(createFactory: false)
class FileType {
  final String type;

  FileType({
    required this.type,
  });

  Map<String, dynamic> toJson() => _$FileTypeToJson(this);
}

@JsonSerializable(createFactory: false)
class Slide {
  final int order;

  Slide({
    required this.order,
  });

  factory Slide.fromIndex(int index) {
    return Slide(order: index + 1);
  }

  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable(createFactory: false)
class Source {
  final List<FileType> fileTypes;
  final List<Slide> slides;

  Source({
    required this.fileTypes,
    required this.slides,
  });

  factory Source.create({
    required List<String> fileTypes,
    required int slideCount,
  }) {
    return Source(
      fileTypes: fileTypes.map((e) => FileType(type: e)).toList(),
      slides: List.generate(slideCount, (index) => Slide.fromIndex(index)),
    );
  }

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'content_type.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
