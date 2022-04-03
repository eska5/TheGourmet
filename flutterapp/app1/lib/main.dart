import 'package:app1/screens/ImageRecon.dart';
import 'package:app1/screens/ImageUpload.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

const String _title = 'The Gourmet';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        //primaryColor: primaryColor,
      ),
      home: const MyStatelessWidget(),
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
          toolbarHeight: 70,
          centerTitle: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text(
              "Gourmet",
              style: TextStyle(fontSize: 20),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(18.0),
                primary: Colors.black,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageRecon()),
                );
              },
              child: const Text('Rozpoznaj'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(18.0),
                primary: Colors.black,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageUpload()),
                );
              },
              child: const Text('Dodaj nowe'),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/main.jpg", height: 300)),
          ],
        ));
  }
}
