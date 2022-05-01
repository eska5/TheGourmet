import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/screens/mealsuggestions.dart';
import 'package:universal_platform/universal_platform.dart';


//String domain = getDomain(1);
//String domain = "192.168.1.54:5000";
String domain = getDomain(0); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

class AddImage extends StatefulWidget {
  AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? mobileImage;
  Uint8List? webImage;
  String mealName = "Nazwa twojej potrawy";

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
        print('Failed to pick image: $e');
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

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MealSuggestions()),
    );
    setState(() {
      String message = "";
      if (result == "") {
        message = "Nie wprowadzono żadnej nazwy";
        mealName = "Brak";
      } else {
        message = "Wprowadzono $result ";
        mealName = result;
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

      if (kIsWeb) {
        bytes = webImage;
      } else {
        bytes = File(mobileImage!.path).readAsBytesSync();
      }

      String base64Image = base64Encode(bytes!);
      Map<String, dynamic> body = {
        'mealName': mealName,
        'mealPhoto': base64Image
      };
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
      //child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: smallSreen() ? 35 : 80,
          ),
          webImage == null && mobileImage == null
              ? Image.asset('assets/dish.png', width: 200, height: 200)
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
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Text(mealName,
              style: GoogleFonts.comfortaa(
                fontSize: 26,
                textStyle: TextStyle(letterSpacing: 0),
              )),
          Expanded(child: Container()),
          NavigationButton(
              title: "Nazwij potrawę",
              icon: Icons.text_fields_rounded,
              onClicked: () => _navigateAndDisplaySelection(context)),
          const SizedBox(
            height: 15,
          ),
          UploadImageButton(
              title: "Wybierz zdjęcie",
              icon: Icons.image_rounded,
              onClicked: () => pickImage(ImageSource.gallery)),
          const SizedBox(
            height: 15,
          ),
          TakeImageButton(
              title: "Zrób zdjęcie",
              icon: Icons.camera_alt_rounded,
              onClicked: () => pickImage(ImageSource.camera)),
          const SizedBox(
            height: 15,
          ),
          SubmitImageButton(
              title: "Wyślij potrawę",
              icon: Icons.send_rounded,
              onClicked: () => sendToServer()),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
      //),
    );
  }
}
