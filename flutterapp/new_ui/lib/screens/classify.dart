import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/suggestions.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ClassifyImage extends StatefulWidget {
  ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _AddImageState();
}

class _AddImageState extends State<ClassifyImage> {
  File? image;
  TextEditingController inputText = new TextEditingController();
  TextEditingController recognizedMeal = new TextEditingController(text :"Tutaj pojawi się wynik");
  String modelOutput = 'Tutaj pojawi się wynik';

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future categorizeThePhoto() async {
    try {
      final uri = Uri.parse("https://gourmet.hopto.org:5000/classify");
      final headers = {'Content-Type': 'application/json'};
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      Map<String, dynamic> body = {'mealPhoto': base64Image};
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      int statusCode = response.statusCode;
      String responseBody = response.body;

      print(responseBody);
      //recognizedMeal.text = json.decode(response.body);
      //modelOutput = json.decode(response.body);
      setState(() {
        modelOutput = json.decode(response.body);
      });
      print(statusCode);
      print("OK");
    } on PlatformException catch (e) {
      print('Failed to send to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[50],
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.file(
                    image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset('assets/diet.png', width: 200, height: 200),
          SizedBox(
            height: 55,
          ),
          Text(modelOutput,
              style: GoogleFonts.comfortaa(
                fontSize: 26,
                textStyle: TextStyle(letterSpacing: 0),
              )),
          Expanded(child: Container()),
          UploadImageButton(
              title: "Wybierz zdjęcie",
              icon: Icons.image_rounded,
              onClicked: () => pickImage(ImageSource.gallery)),
          SizedBox(
            height: 15,
          ),
          TakeImageButton(
              title: "Zrób zdjęcie",
              icon: Icons.camera_alt_rounded,
              onClicked: () => pickImage(ImageSource.camera)),
          SizedBox(
            height: 15,
          ),
          ClassifyImageButton(
            title: 'Rozpoznaj potrawę',
            icon: Icons.fastfood_rounded,
            onClicked: () => categorizeThePhoto(),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
