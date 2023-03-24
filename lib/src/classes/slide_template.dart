import 'package:json_annotation/json_annotation.dart';

part 'slide_template.g.dart';

@JsonSerializable(createFactory: false)
class SlideTemplate {
  final String name;
  final int layoutId;

  const SlideTemplate(this.name, this.layoutId);

  factory SlideTemplate.titleSlide() {
    return const SlideTemplate('Title Slide', 1);
  }

  factory SlideTemplate.titleAndContent() {
    return const SlideTemplate('Title and Content', 2);
  }

  factory SlideTemplate.sectionHeader() {
    return const SlideTemplate('Section Header', 3);
  }

  factory SlideTemplate.twoContent() {
    return const SlideTemplate('Two Content', 4);
  }

  factory SlideTemplate.comparison() {
    return const SlideTemplate('Comparison', 5);
  }

  factory SlideTemplate.titleOnly() {
    return const SlideTemplate('Title Only', 6);
  }

  factory SlideTemplate.blank() {
    return const SlideTemplate('Blank', 7);
  }

  factory SlideTemplate.contentWithCaption() {
    return const SlideTemplate('Content with Caption', 8);
  }

  factory SlideTemplate.pictureWithCaption() {
    return const SlideTemplate('Picture with Caption', 9);
  }

  factory SlideTemplate.titleWithVerticalText() {
    return const SlideTemplate('Title and Vertical Text', 10);
  }

  factory SlideTemplate.verticalTitleWithText() {
    return const SlideTemplate('Vertical Title and Text', 11);
  }

  Map<String, dynamic> toJson() => _$SlideTemplateToJson(this);
}
