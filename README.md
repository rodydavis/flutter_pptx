# Flutter PPTX

A Flutter plugin for creating PowerPoint presentations.

## Getting Started

```dart
import 'package:flutter_pptx/flutter_pptx.dart';

final pres = Powerpoint();
```

## Adding Slides

### Title Slide

```dart
pres.addTitleSlide(
    title: 'Title'.toTextValue(),
);
```

### Title and Photo Slide

```dart
pres.addTitleAndPhotoSlide(
    title: 'Title'.toTextValue(),
    image: ImageReference(
        path: './samples/images/sample_gif.gif',
        name: 'Sample Gif',
    ),
);
```

### Title and Photo Slide (Alternative)

```dart
pres.addTitleAndPhotoAltSlide(
    title: 'Title'.toTextValue(),
    image: ImageReference(
        path: './samples/images/sample_jpg.jpg',
        name: 'Sample Jpg',
    ),
);
```

### Title and Bullets Slide

```dart
pres.addTitleAndBulletsSlide(
    title: 'Title'.toTextValue(),
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ].map((e) => e.toTextValue()).toList(),
);
```

### Bullets Slide

```dart
pres.addBulletsSlide(
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ].map((e) => e.toTextValue()).toList(),
);
```

### Title, Bullets, and Photo Slide

```dart
pres.addTitleBulletsAndPhotoSlide(
    title: 'Title'.toTextValue(),
    image: ImageReference(
        path: './samples/images/sample_jpg.jpg',
        name: 'Sample Jpg',
    ),
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ].map((e) => e.toTextValue()).toList(),
);
```

### Section Slide

```dart
pres.addSectionSlide(
    section: 'Section 1'.toTextValue(),
);
```

### Title Only Slide

```dart
pres.addTitleOnlySlide(
    title: 'Title 1',
    subtitle: 'Subtitle 1',
);
```

### Agenda Slide

```dart
pres.addAgendaSlide(
    title: 'Title 1',
    subtitle: 'Subtitle 1',
    topics: 'Topics 1',
);
```

### Statement Slide

```dart
pres.addStatementSlide(
    statement: 'Statement 1',
);
```

### Big Fact Slide

```dart
pres.addBigFactSlide(
    fact: 'Fact 1',
    information: 'Information 1',
);
```

### Quote Slide

```dart
pres.addQuoteSlide(
    quote: 'Quote 1',
    attribution: 'Attribution 1',
);
```

### Photo 3 Up Slide

```dart
pres.addPhoto3UpSlide(
    image1: ImageReference(
        path: './samples/images/sample_gif.gif',
    ),
    image2: ImageReference(
        path: './samples/images/sample_jpg.jpg',
    ),
    image3: ImageReference(
        path: './samples/images/sample_png.png',
    ),
);
```

### Photo Slide

```dart
pres.addPhotoSlide(
    image: ImageReference(
        path: './samples/images/sample_gif.gif',
    ),
);
```

### Blank Slide

```dart
pres.addBlankSlide();
```

## Widget Slide

```dart
await pres.addWidget(Center(
  child: Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.blueAccent, width: 5.0),
      color: Colors.redAccent,
    ),
    child: const Text("This is an invisible widget"),
  ),
));
```

Thanks to the [screenshot](https://pub.dev/packages/screenshot) package!

## Background Properties

### Background Color

```dart
slide.background.color = '000000';
```

### Background Image

```dart
slide.background.image = ImageReference(
    path: './samples/images/sample_gif.gif',
    name: 'Sample Gif',
);
```

## Presentation Properties

### Show/Hide Slide Number

```dart
pres.showSlideNumber = true;
```

## Exporting

### Save to bytes

```dart
final bytes = await pres.save();
```

## Links

- https://github.com/pythonicrubyist/powerpoint