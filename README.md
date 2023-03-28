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
pres.addTitle(
    title: 'Title',
);
```

### Title and Photo Slide

```dart
pres.addTitleAndPhoto(
    title: 'Title',
    imagePath: './samples/images/sample_gif.gif',
    imageName: 'Sample Gif',
);
```

### Title and Photo Slide (Alternative)

```dart
pres.addTitleAndPhotoAlt(
    title: 'Title',
    imagePath: './samples/images/sample_jpg.jpg',
    imageName: 'Sample Jpg',
);
```

### Title and Bullets Slide

```dart
pres.addTitleAndBullets(
    title: 'Title',
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ],
);
```

### Bullets Slide

```dart
pres.addBullets(
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ],
);
```

### Title, Bullets, and Photo Slide

```dart
pres.addSlideTitleBulletsAndPhoto(
    title: 'Title',
    imagePath: './samples/images/sample_jpg.jpg',
    imageName: 'Sample Jpg',
    bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
    ],
);
```

### Section Slide

```dart
pres.addSection(
    section: 'Section 1',
);
```

### Title Only Slide

```dart
pres.addSlideTitleOnly(
    title: 'Title 1',
    subtitle: 'Subtitle 1',
);
```

### Agenda Slide

```dart
pres.addSlideAgenda(
    title: 'Title 1',
    subtitle: 'Subtitle 1',
    topics: 'Topics 1',
);
```

### Statement Slide

```dart
pres.addSlideStatement(
    statement: 'Statement 1',
);
```

### Big Fact Slide

```dart
pres.addBigFact(
    fact: 'Title 1',
    information: 'Fact 1',
);
```

### Quote Slide

```dart
pres.addSlideQuote(
    quote: 'Quote 1',
    attribution: 'Attribution 1',
);
```

### Photo 3 Up Slide

```dart
pres.addSlidePhoto3Up(
    image1Path: './samples/images/sample_gif.gif',
    image2Path: './samples/images/sample_jpg.jpg',
    image3Path: './samples/images/sample_png.png',
);
```

### Photo Slide

```dart
pres.addSlidePhoto(
    imagePath: './samples/images/sample_gif.gif',
);
```

### Blank Slide

```dart
pres.addSlideBlank();
```

## Widget Slide

```dart
await pres.addSlideWidget(Center(
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