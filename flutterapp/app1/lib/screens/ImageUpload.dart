import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUpload extends StatelessWidget {
  ImageUpload({Key? key}) : super(key: key);

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
