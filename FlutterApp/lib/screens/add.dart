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
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/screens/mealsuggestions.dart';
import 'package:universal_platform/universal_platform.dart';

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

//TEMPORARY
final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    //var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 32, right: 32, top: 80, bottom: 100),
            child: Material(
              color: Colors.indigo,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 16, bottom: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 20,
                            bottom: 20), //apply padding to all four sides
                        child: Text("Status przesłania",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                              fontSize: 32,
                              textStyle: const TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 10,
                            bottom: 20), //apply padding to all four sides
                        child: RichText(
                          text: TextSpan(
                            text: responseText1,
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              textStyle: const TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: responseText2,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  textStyle: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: responseColor == "Colors.green"
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                              TextSpan(
                                text: responseText3,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 15,
                            bottom: 15), //apply padding to all four sides
                        child: SizedBox(
                          width: 235, // <-- Your width
                          height: 60, // <-- Your height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.indigo,

                              textStyle: TextStyle(fontSize: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              //minimumSize: const Size(40, 60),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.exit_to_app_outlined, size: 28),
                                SizedBox(width: 10),
                                Text("Powrót"),
                              ],
                            ),
                            onPressed: () => Navigator.pop(
                                context, _LoaderDialog.currentContext),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? mobileImage;
  Uint8List? webImage;
  String mealName = "Nazwa twojej potrawy";

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

      //TO DO Make a Catch for a error when user is posting a photo
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
        print(statusCode);
        print("OK");
      }

      if (statusCode == 200) {
        responseText1 = "Zdjęcie zostało ";
        responseText2 = "poprawnie ";
        responseText3 = "wysłane, odebrane i zapisane !";
        responseColor = "Colors.green";
      } else if (statusCode == 500) {
        responseText1 = "Serwer ";
        responseText2 = "nie odebrał ";
        responseText3 =
            "zdjęcia. Prawdopodobnie serwer jest chwilowo wyłączony.";
        responseColor = "Colors.red";
      } else if (statusCode == 400) {
        responseText1 = "";
        responseText2 = "Nie odnaleziono ";
        responseText3 = "serwera !";
        responseColor = "Colors.red";
      } else {
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "odebrane, niezidentyfikowany problem !";
        responseColor = "Colors.red";
      }
      LoaderDialog.showLoadingDialog(context, _LoaderDialog);
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
        padding: const EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: smallSreen() ? 5 : 10,
          ),
          Center(
            child: Text(
                'Dodaj nową potrawę do bazy danych!\n1. Zrób albo wybierz zdjęcie\n2. Nazwij je\n3. Wyślij',
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
          ),
          SizedBox(
            height: smallSreen() ? 25 : 40,
          ),
          Center(
            child: Text(mealName,
                style: GoogleFonts.comfortaa(
                  fontSize: 26,
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
                onClicked: () => _navigateAndDisplaySelection(context)),
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
                title: "Zrób zdjęcie",
                icon: Icons.camera_alt_rounded,
                onClicked: () => pickImage(ImageSource.camera)),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: SubmitImageButton(
                title: "Wyślij potrawę",
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
