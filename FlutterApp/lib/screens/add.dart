import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/screens/mealsuggestions.dart';
import 'package:universal_platform/universal_platform.dart';

import '../components/loaderdialog.dart';

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

String responseTitle = "";
String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();
  bool _customTileExpanded = false;

  Future pickImage(ImageSource source) async {
    //WEB
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
          LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
              responseText1, responseText2, responseText3, responseColor);
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
    //MOBILE
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
          LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
              responseText1, responseText2, responseText3, responseColor);
          return;
        }
        final imageTemporary = File(image.path);
        setState(() => globals.mobileImageAdd = imageTemporary);
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

      if (!validateRequest("Add")) {
        responseTitle = "Nie wybrano zdjęcia lub podpisu potrawy";
        responseText1 = "Zanim dodasz zdjęcie potrawy, ";
        responseText2 = "";
        responseText3 =
            "załaduj zdjęcie z galerii lub aparatu i upewnij się, że dodano nazwę potrawy";
        responseColor = "Colors.red";
        LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
            responseText1, responseText2, responseText3, responseColor);
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

      try {
        //TO DO Make a Catch for a error when user is posting a photo
        var response = await http
            .post(
              uri,
              headers: headers,
              body: jsonBody,
              encoding: encoding,
            )
            .timeout(Duration(seconds: 1));

        int statusCode = response.statusCode;
        String responseBody = response.body;
        if (kDebugMode) {
          print(responseBody);
          print(statusCode);
          print("OK");
        }
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
      LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
          responseText1, responseText2, responseText3, responseColor);
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
      //child: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: 13.0, right: 13.0, bottom: 13.0, top: 45),
        children: [
          ExpansionTile(
            title: const Text(
              'Dodanie nowego zdjęcia',
              style: TextStyle(fontSize: 23),
              textAlign: TextAlign.center,
            ),
            subtitle: const Text('Kliknij po dodatkowe informacje',
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.arrow_circle_up_rounded
                  : Icons.arrow_circle_down_rounded,
            ),
            children: const <Widget>[
              ListTile(
                title: Text(
                  'Krótka instrukcja jak dodać nową potrawę do bazy danych.\n1. Zrób albo wybierz zdjęcie.\n2. Nazwij potrawę przez ekran "Nazwij potrawę".\n3. Wyślij.\n\nTwoje zdjęcie potrawy trafi do zbioru danych i zostanie użyte w przyszłości do doskonalenia modelu.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
          SizedBox(
            height: smallSreen() ? 5 : 10,
          ),
          Center(
            child: globals.webImageAdd == null && globals.mobileImageAdd == null
                ? Image.asset('assets/dish.png', width: 200, height: 200)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: kIsWeb
                        ? Image.memory(
                            globals.webImageAdd!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            globals.mobileImageAdd!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
          ),
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Center(
            child: Text(globals.mealTag,
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(
                  fontSize: 22,
                  textStyle: TextStyle(letterSpacing: 0),
                )),
          ),
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Center(
            child: NavigationButton(
              title: "Nazwij potrawę",
              icon: Icons.text_fields_rounded,
              onClicked: () => _navigateAndDisplaySelection(context),
              backgroundColor: Colors.indigo,
              fontSize: 20,
              enabled: true,
            ),
          ),
          const SizedBox(
            height: 15,
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
                title: "  Zrób zdjęcie   ",
                icon: Icons.camera_alt_rounded,
                onClicked: () => pickImage(ImageSource.camera)),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: SubmitImageButton(
                title: "Wyślij potrawę ",
                icon: Icons.send_rounded,
                onClicked: () => sendToServer()),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
      //),
    );
  }
}
