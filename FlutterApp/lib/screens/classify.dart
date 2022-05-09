import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/functions/func.dart';
import 'package:universal_platform/universal_platform.dart';

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
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
  const ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _AddImageState();
}

class _AddImageState extends State<ClassifyImage> {
  File? mobileImage;
  Uint8List? webImage;
  TextEditingController inputText = new TextEditingController();
  TextEditingController recognizedMeal =
      TextEditingController(text: "Tutaj pojawi się wynik");
  String modelOutput = 'Tutaj pojawi się wynik';

  // ignore: non_constant_identifier_names
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

  Future pickImage(ImageSource source) async {
    //WEB
    if (kIsWeb) {
      try {
        final image = await ImagePicker()
            .pickImage(source: source, maxWidth: 400, maxHeight: 400);
        if (image == null) return;

        final imageTemporary = await image.readAsBytes();
        setState(() {
          webImage = imageTemporary;
        });
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
    }
    //MOBILE
    else {
      try {
        final image = await ImagePicker()
            .pickImage(source: source, maxWidth: 400, maxHeight: 400);
        if (image == null) return;

        final imageTemporary = File(image.path);
        setState(() => mobileImage = imageTemporary);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future categorizeThePhoto() async {
    try {
      if (!UniversalPlatform.isWeb) {
        final ioc = HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) =>
                host == 'localhost:5000';
        final http = IOClient(ioc);
      }

      final uri = Uri.parse(domain + "/classify");
      final headers = {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      };

      Uint8List? bytes;
      if (kIsWeb) {
        bytes = webImage;
      } else {
        bytes = File(mobileImage!.path).readAsBytesSync();
      }

      String base64Image = base64Encode(bytes!);
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

      if (kDebugMode) {
        print(responseBody);
      }
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
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: smallSreen() ? 5 : 10,
          ),
          Center(
            child: Text(
                'Rozpoznaj swoją potrawę!\n1. Zrób albo wybierz zdjęcie\n2. Kliknij przycisk rozpoznaj i poczekaj na wynik',
                textAlign: TextAlign.left,
                style: GoogleFonts.caveat(
                  fontSize: 25,
                )),
          ),
          SizedBox(
            height: smallSreen() ? 5 : 10,
          ),
          Center(
            child: webImage == null && mobileImage == null
                ? Image.asset('assets/diet.png', width: 200, height: 200)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: kIsWeb
                        ? Image.memory(
                            webImage!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            mobileImage!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
          ),
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Center(
            child: Text(modelOutput,
                style: GoogleFonts.comfortaa(
                  fontSize: 26,
                  textStyle: TextStyle(letterSpacing: 0),
                )),
          ),
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Center(
            child: UploadImageButton(
                title: "Wybierz zdjęcie",
                icon: Icons.image_rounded,
                onClicked: () => pickImage(ImageSource.gallery)),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: TakeImageButton(
                title: "Zrób zdjęcie",
                icon: Icons.camera_alt_rounded,
                onClicked: () => pickImage(ImageSource.camera)),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ClassifyImageButton(
              title: 'Rozpoznaj potrawę',
              icon: Icons.fastfood_rounded,
              onClicked: () => categorizeThePhoto(),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
