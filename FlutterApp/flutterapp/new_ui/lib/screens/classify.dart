import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/components/button.dart';
import 'package:new_ui/functions/func.dart';

String domain = getDomain(0); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(70))),
              key: key,
              backgroundColor: Colors.indigo[50],
              child: Container(
                width: 150.0,
                height: 250.0,
                child: Image.asset(
                  'assets/plate.gif',
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              )),
        );
      },
    );
  }
}

class ClassifyImage extends StatefulWidget {
  ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _AddImageState();
}

class _AddImageState extends State<ClassifyImage> {
  File? image;
  TextEditingController inputText = new TextEditingController();
  TextEditingController recognizedMeal =
      new TextEditingController(text: "Tutaj pojawi się wynik");
  String modelOutput = 'Tutaj pojawi się wynik';
  // ignore: non_constant_identifier_names
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future categorizeThePhoto() async {
    try {
      final uri = Uri.parse(domain + "/classify");
      final headers = {'Content-Type': 'application/json'};
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      Map<String, dynamic> body = {'mealPhoto': base64Image};
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      LoaderDialog.showLoadingDialog(context, _LoaderDialog);

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
        Navigator.pop(context, _LoaderDialog.currentContext);
        modelOutput = json.decode(response.body);
      });
      if (kDebugMode) {
        print(statusCode);
        print("OK");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to send to server: $e');
      }
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
            height: smallSreen() ? 35 : 80,
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
            height: smallSreen() ? 25 : 40,
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
