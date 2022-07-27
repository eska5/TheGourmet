import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/common/button.dart';
import 'package:new_ui/resources/common/globals.dart' as globals;
import 'package:new_ui/screens/suggestions.dart';
import 'package:universal_platform/universal_platform.dart';

import '../resources/common/methods.dart';
import '../resources/common/snack_bars.dart';

class _AddImage extends StatefulWidget {
  const _AddImage({Key? key}) : super(key: key);

  @override
  State<_AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<_AddImage> {
  String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

  // Response popUp variables
  String responseTitle = "";
  String responseText1 = "";
  String responseText2 = "";
  String responseText3 = "";
  String responseColor = "";

  // Picking image
  Future pickImage(ImageSource source) async {
    // WEB
    if (kIsWeb) {
      try {
        final image = await ImagePicker()
            .pickImage(source: source, maxWidth: 400, maxHeight: 400);
        if (image == null) return;

        if (!validateFileExtension(image)) {
          responseTitle = "Wybrano niepoprawyny format";
          responseText1 = "Rozszerzenie twojego zdjęcia jest ";
          responseText2 = "niepoprawne";
          responseText3 = ". Akceptowane formaty : jpg, jpeg, png";
          responseColor = "Colors.red";
          showErrorMessage(context, responseTitle);
          return;
        }

        final imageTemporary = await image.readAsBytes();
        setState(() {
          globals.webImageAdd = imageTemporary;
        });
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
    }
    // MOBILE
    else {
      try {
        final image = await ImagePicker()
            .pickImage(source: source, maxWidth: 400, maxHeight: 400);
        if (image == null) return;

        if (!validateFileExtension(image)) {
          responseTitle = "Wybrano niepoprawyny format";
          responseText1 = "Rozszerzenie twojego zdjęcia jest ";
          responseText2 = "niepoprawne";
          responseText3 = ". Akceptowane formaty : jpg, jpeg, png";
          responseColor = "Colors.red";
          showErrorMessage(context, responseTitle);
          return;
        }

        final imageTemporary = File(image.path);
        setState(() => globals.mobileImageAdd = imageTemporary);
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
    }
  }

  // Meal name Confirmation <for user>
  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MealSuggestions()),
    );
    setState(() {
      String message = "";
      if (result == "") {
        message = "Nie wprowadzono żadnej nazwy";
        globals.mealTag = "Brak";
      } else {
        message = "Wprowadzono $result ";
        globals.mealTag = result;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        action: SnackBarAction(
          label: 'Okej',
          onPressed: () {},
        ),
      ));
    });
  }

  // Sending mealPhoto and mealName to server
  Future sendToServer() async {
    try {
      if (!UniversalPlatform.isWeb) {
        final ioc = HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) =>
                host == 'localhost:5000';
        final http = IOClient(ioc);
      }

      final uri = Uri.parse(domain + "/meals");
      final headers = {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      };
      Uint8List? bytes;
      // Response when photo or name were not given
      if (!validateRequest("Add")) {
        responseTitle = "Nie wybrano zdjęcia lub podpisu potrawy";
        responseText1 = "Zanim dodasz zdjęcie potrawy, ";
        responseText2 = "";
        responseText3 =
            "załaduj zdjęcie z galerii lub aparatu i upewnij się, że dodano nazwę potrawy";
        responseColor = "Colors.red";
        showErrorMessage(context, responseTitle);
        return;
      }

      if (kIsWeb) {
        bytes = globals.webImageAdd;
      } else {
        bytes = File(globals.mobileImageAdd!.path).readAsBytesSync();
      }

      String base64Image = base64Encode(bytes!);
      Map<String, dynamic> body = {
        'mealName': globals.mealTag,
        'mealPhoto': base64Image
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      // Try catch error handling
      try {
        var response = await http
            .post(
              uri,
              headers: headers,
              body: jsonBody,
              encoding: encoding,
            )
            .timeout(const Duration(seconds: 1));

        int statusCode = response.statusCode;
        String responseBody = response.body;
        if (kDebugMode) {
          print(responseBody);
          print(statusCode);
          print("OK");
        }
        // Good request
        responseTitle = "Status przesłania";
        if (statusCode == 200) {
          responseText1 = "Zdjęcie zostało ";
          responseText2 = "poprawnie ";
          responseText3 = "wysłane, odebrane i zapisane !";
          responseColor = "Colors.green";
        }
      } on TimeoutException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "odebrane, przekroczono limit czasu !";
        responseColor = "Colors.red";
      } on SocketException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "odebrane, niewłaściwy adres serwera !";
        responseColor = "Colors.red";
      }
      // Snackbar Response <for user>
      responseColor == "Colors.red"
          ? showErrorMessage(
              context, (responseText1 + responseText2 + responseText3))
          : showSuccessMessage(
              context, (responseText1 + responseText2 + responseText3));
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to send to server: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Shows that we are not in classify
    return Scaffold(
      // Top of the screen
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.add_photo_alternate_rounded, size: 29),
        title: const Text('Dodaj nową potrawę', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo[50],
      // Below the top of the screen
      body: ListView(
        padding:
            const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 13.0, top: 0),
        children: [
          // Meal name container Sticked to appBar on top
          Container(
            margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            height: 65,
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(45.0),
                bottomLeft: Radius.circular(45.0),
              ),
            ),
            child: Center(
              child: Text(
                globals.mealTag,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 21),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Stack(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(
                      left: 13.0, top: 100, right: 13.0, bottom: 100)),
              // Center(
              //     // Display image
              //     child: imageContainer()), #TODO CHANGE IT TO NEW WIDGET
              Positioned(
                right: 30.0,
                top: 180.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Upload image button
                    smallImageButton(
                        icon: Icons.image_rounded,
                        color: Colors.indigoAccent,
                        isRight: false,
                        onClicked: () => pickImage(ImageSource.gallery)),
                    // Take image button
                    smallImageButton(
                        icon: Icons.camera_alt_rounded,
                        color: Colors.indigoAccent,
                        isRight: true,
                        onClicked: () => pickImage(ImageSource.camera)),
                  ],
                ),
              ),
              const SizedBox(
                height: 220,
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          Center(
            // Name the meal button
            child: generalButton(
              title: "Nazwij potrawę",
              icon: Icons.text_fields_rounded,
              color: const Color(0xFFFE9901),
              textColor: Colors.white,
              onClicked: () => _navigateAndDisplaySelection(context),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            // Send the meal button
            child: generalButton(
                title: "Wyślij potrawę  ",
                icon: Icons.send_rounded,
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                onClicked: () => sendToServer()),
          ),
        ],
      ),
    );
  }
}
