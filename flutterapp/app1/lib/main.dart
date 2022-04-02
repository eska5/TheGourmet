import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Text(
            "The Gourmet",
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              style:
              TextButton.styleFrom(
                primary: Colors.black, // Background color
                backgroundColor: Colors.amber, // Text Color (Foreground color)
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ModelRoute()),
              );
            },
            child: const Text('Rozpoznaj'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              style:
              TextButton.styleFrom(
                backgroundColor: Colors.black, // Text Color (Foreground color)
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadRoute()),
              );
            },
            child: const Text('Dodaj nowe'),
          )
        ],
      ),
    );
  }
}

class ModelRoute extends StatelessWidget {
  ModelRoute({Key? key}) : super(key: key);

  File imgPreview = File('assets/pepegadroid.jpg');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('The Gourmet')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Image.file(
                  imgPreview,
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 90),
            Container(
              child: const Text('Tutaj będzie wynik :)'),
            ),
            SizedBox(height: 90),
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {},
                child: Text("Dodaj zdjęcie"),
              ),
            ),
            SizedBox(height: 30), //zamienić na padding
          ],
        ));
  }
}

class UploadRoute extends StatelessWidget {
  const UploadRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('The Gourmet')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Image.asset(
                  'assets/pepegadroid.jpg',
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 90),
            Container(
              child: const Text('zdjęcie wysłane :)'),
            ),
            SizedBox(height: 90),
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {},
                child: Text("Dodaj zdjęcie"),
              ),
            ),
            SizedBox(height: 30), //zamienić na padding
          ],
        ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    // if (pickedFile != null) { // TO DO
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }
}
