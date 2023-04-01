import 'package:flutter/material.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

import 'download/download.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const MyHomePage(title: 'Presentation Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<FlutterPowerPoint> createPresentation() async {
    final pres = FlutterPowerPoint();

    pres.addTitleSlide(
      title: 'Slide one'.toTextValue(),
    );

    pres.addTitleAndPhotoSlide(
      title: 'Slide two'.toTextValue(),
      image: ImageReference(
        path: 'assets/images/sample_gif.gif',
        name: 'Sample Gif',
      ),
    );

    pres.addTitleAndPhotoAltSlide(
      title: 'Slide three'.toTextValue(),
      image: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Sample Jpg',
      ),
    );

    pres
        .addTitleAndBulletsSlide(
          title: 'Slide three'.toTextValue(),
          bullets: [
            'Bullet 1',
            'Bullet 2',
            'Bullet 3',
            'Bullet 4',
          ].map((e) => e.toTextValue()).toList(),
        )
        .speakerNotes = TextValue.uniform('This is a note!');

    pres
        .addBulletsSlide(
          bullets: [
            'Bullet 1',
            'Bullet 2',
            'Bullet 3',
            'Bullet 4',
          ].map((e) => e.toTextValue()).toList(),
        )
        .speakerNotes = TextValue.singleLine([
      TextItem('This '),
      TextItem('is ', isBold: true),
      TextItem('a ', isUnderline: true),
      TextItem('note!'),
    ]);

    pres.addTitleBulletsAndPhotoSlide(
      title: 'Slide five'.toTextValue(),
      image: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Sample Jpg',
      ),
      bullets: [
        'Bullet 1',
        'Bullet 2',
        'Bullet 3',
        'Bullet 4',
      ].map((e) => e.toTextValue()).toList(),
    );

    pres
        .addSectionSlide(
          section: 'Section 1'.toTextValue(),
        )
        .speakerNotes = TextValue.multiLine([
      TextValueLine(values: [
        TextItem('This '),
        TextItem('is ', isBold: true),
        TextItem('a ', isUnderline: true),
        TextItem('note 1!'),
      ]),
      TextValueLine(values: [
        TextItem('This '),
        TextItem('is ', isBold: true),
        TextItem('a ', isUnderline: true),
        TextItem('note 2!'),
      ]),
    ]);

    pres.addTitleOnlySlide(
      title: 'Title 1'.toTextValue(),
      subtitle: 'Subtitle 1'.toTextValue(),
    );

    pres.addAgendaSlide(
      title: 'Title 1'.toTextValue(),
      subtitle: 'Subtitle 1'.toTextValue(),
      topics: 'Topics 1'.toTextValue(),
    );

    pres.addStatementSlide(
      statement: 'Statement 1'.toTextValue(),
    );

    pres.addBigFactSlide(
      fact: 'Title 1'.toTextLine(),
      information: 'Fact 1'.toTextValue(),
    );

    pres.addQuoteSlide(
      quote: 'Quote 1'.toTextLine(),
      attribution: 'Attribution 1'.toTextValue(),
    );

    pres.addPhoto3UpSlide(
      image1: ImageReference(
        path: 'assets/images/sample_gif.gif',
        name: 'Sample Gif',
      ),
      image2: ImageReference(
        path: 'assets/images/sample_jpg.jpg',
        name: 'Sample Jpg',
      ),
      image3: ImageReference(
        path: 'assets/images/sample_png.png',
        name: 'Sample Png',
      ),
    );

    pres.addPhotoSlide(
      image: ImageReference(
        path: 'assets/images/sample_gif.gif',
        name: 'Sample Gif',
      ),
    );

    pres.addBlankSlide();

    pres.addBlankSlide().background.color = '000000';

    pres.addBlankSlide().background.image = ImageReference(
      path: 'assets/images/sample_gif.gif',
      name: 'Sample Gif',
    );

    await pres.addWidgetSlide(
      Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 5.0),
            color: Colors.redAccent,
          ),
          child: const Text("This is an invisible widget"),
        ),
      ),
    );

    pres.showSlideNumber = true;

    return pres;
  }

  Future<void> downloadPresentation(FlutterPowerPoint pres) async {
    final bytes = await pres.save();
    if (bytes == null) return;
    downloadFile('presentation.pptx', bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pres = await createPresentation();
            await downloadPresentation(pres);
          },
          child: const Text('Download Presentation'),
        ),
      ),
    );
  }
}
