import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageRecon extends StatefulWidget {
  ImageRecon({Key? key}) : super(key: key);

  @override
  State<ImageRecon> createState() => _ImageReconState();
}

class _ImageReconState extends State<ImageRecon> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Gourmet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 260,
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    "assets/uploadicon.jpg",
                    width: 200,
                    height: 200,
                  ),
            const SizedBox(height: 60),
            buildButton(
              title: 'Pick Gallery',
              icon: Icons.image_outlined,
              onClicked: () => pickImage(ImageSource.gallery),
            ),
            const SizedBox(height: 28),
            buildButton(
              title: 'Pick Camera',
              icon: Icons.camera_alt_outlined,
              onClicked: () => pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 28),
            buildButton(
              title: 'Submit',
              icon: Icons.send,
              onClicked: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      SizedBox(
        height: 60,
        width: 250,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(56),
            primary: Colors.amber,
            onPrimary: Colors.black,
            shadowColor: Colors.black,
            shape: StadiumBorder(),
            textStyle: TextStyle(fontSize: 20),
          ),
          child: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 16),
              Text(title),
            ],
          ),
          onPressed: onClicked,
        ),
      );
}
