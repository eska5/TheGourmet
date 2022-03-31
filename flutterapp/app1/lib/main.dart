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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ModelRoute()),
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
  const ModelRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rozpoznaj potrawę ze zdjęcia'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class UploadRoute extends StatelessWidget {
  const UploadRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj nowe zdjęcie'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigator.pop(context);
            _getFromGallery();
          },
          child: const Text('Wybierz zdjęcie z galerii'),
        ),
      ),
    //   : Container( //TO DO
    //           child: Image.file(
    //             imageFile,
    //             fit: BoxFit.cover,
    //           ),
    //         )));
    // );
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
