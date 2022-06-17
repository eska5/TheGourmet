import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/screens/catalog.dart';
import 'package:new_ui/screens/result.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:new_ui/components/tile.dart';

import '../components/loaderdialog.dart';

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

String responseTitle = "";
String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

class LoaderDialog2 {
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
  TextEditingController inputText = new TextEditingController();
  TextEditingController recognizedMeal =
      TextEditingController(text: "Tutaj pojawi się wynik");

  // ignore: non_constant_identifier_names
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();
  final GlobalKey<State> _LoaderDialog2 = GlobalKey<State>();
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
          showTopSnackBarCustomError(context,  responseTitle);
          // LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
          //     responseText1, responseText2, responseText3, responseColor);
          return;
        }
        final imageTemporary = await image.readAsBytes();
        setState(() {
          globals.webImageClassify = imageTemporary;
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
          showTopSnackBarCustomError(context,  responseTitle);
          // LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
          //     responseText1, responseText2, responseText3, responseColor);
          return;
        }
        final imageTemporary = File(image.path);
        setState(() => globals.mobileImageClassify = imageTemporary);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModelResult()),
    );
  }

  void _navigateAndDisplaySelection2(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MealCatalog()),
    );
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

      if (!validateRequest("Classify")) {
        responseTitle = "Nie wybrano zdjęcia";
        responseText1 = "Zanim poprosisz o rozpoznanie potrawy, ";
        responseText2 = "";
        responseText3 = "załaduj zdjęcie z galerii lub aparatu";
        responseColor = "Colors.red";
        showTopSnackBarCustomError(context,  responseTitle);
        // LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
        //     responseText1, responseText2, responseText3, responseColor);
        return;
      }

      Uint8List? bytes;
      if (kIsWeb) {
        bytes = globals.webImageClassify;
      } else {
        bytes = File(globals.mobileImageClassify!.path).readAsBytesSync();
      }

      String base64Image = base64Encode(bytes!);
      Map<String, dynamic> body = {'mealPhoto': base64Image};
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      LoaderDialog2.showLoadingDialog(context, _LoaderDialog2);

      try {
        var response = await http
            .post(
              uri,
              headers: headers,
              body: jsonBody,
              encoding: encoding,
            )
            .timeout(Duration(seconds: 30));

        setState(() {
          // Wypisuje cały response
          //print(json.decode(response.body));
          globals.modelOutput = "test"; //json.decode(response.body);
          globals.modelOutput1 = json.decode(response.body)[0];
          String temp = json.decode(response.body)[1];
          globals.modelChance1 = double.parse(temp);
          globals.modelOutput2 = json.decode(response.body)[2];
          temp = json.decode(response.body)[3];
          globals.modelChance2 = double.parse(temp);
          globals.modelOutput3 = json.decode(response.body)[4];
          temp = json.decode(response.body)[5];
          globals.modelChance3 = double.parse(temp);
          globals.mealClassified = true;
          globals.tile1 = Tile(mealName: globals.modelOutput1, mealDescription: globals.modelOutput1, mealProbability: globals.modelChance1*100, color: globals.firstColor, gradient1: Colors.orange,gradient2: Colors.amber,numberOfStars: 3);
          globals.tile2 = Tile(mealName: globals.modelOutput2, mealDescription: globals.modelOutput2, mealProbability: globals.modelChance2*100, color: globals.secondColor,gradient1: Color(0xFF526573),gradient2: Color(0xFF9CAABD),numberOfStars: 2);
          globals.tile3 = Tile(mealName: globals.modelOutput3, mealDescription: globals.modelOutput3, mealProbability: globals.modelChance3*100, color: globals.thirdColor,gradient1: Color(0xFF7B4C1E),gradient2: Color(0xFFB9772D),numberOfStars: 1);
  
          Navigator.pop(context, _LoaderDialog2.currentContext);
          _navigateAndDisplaySelection(context);
        });
      } on SocketException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, niewłaściwy adres serwera !";
        responseColor = "Colors.red";
        //Navigator.pop(context, _LoaderDialog2.currentContext);
        showTopSnackBarCustomError(context,  (responseText1 + responseText2 + responseText3));
        //LoaderDialog2.showLoadingDialog(context, _LoaderDialog);
      } on TimeoutException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, przekroczono limit czasu !";
        responseColor = "Colors.red";
        //Navigator.pop(context, _LoaderDialog2.currentContext);
        showTopSnackBarCustomError(context,  (responseText1 + responseText2 + responseText3));
        //LoaderDialog2.showLoadingDialog(context, _LoaderDialog);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to send to server: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.calculate_rounded, size: 29),
        title:
            const Text('Rozpoznawanie potrawy', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo[50],
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: 13.0, right: 13.0, bottom: 13.0, top: 45),
        children: [
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: <Widget>[
              Center(
                child: globals.webImageClassify == null &&
                        globals.mobileImageClassify == null
                    ? Image.asset('assets/diet.png', width: 200, height: 200)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: kIsWeb
                            ? Image.memory(
                                globals.webImageClassify!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                globals.mobileImageClassify!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )),
              ),
              Positioned(
                right: 30.0,
                top: 180.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: [
                    UploadImageButton(
                        title: "",
                        icon: Icons.image_rounded,
                        onClicked: () => pickImage(ImageSource.gallery)),
                    TakeImageButton(
                        title: "",
                        icon: Icons.camera_alt_rounded,
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
            height: 40,
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
          Center(
            child: NavigationButton(
              title: "Propozycje potraw",
              icon: Icons.api_rounded,
              //TUTAJ DODAJEMY ZMIENNE DO PRZEKAZANIA :)
              onClicked: () => _navigateAndDisplaySelection(context),
              backgroundColor: Colors.blue[400],
              fontSize: 20,
              enabled: globals.mealClassified,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: NavigationButton(
              title: "Katalog potraw",
              icon: Icons.playlist_add_check_rounded,
              onClicked: () => _navigateAndDisplaySelection2(context),
              backgroundColor: Colors.deepPurpleAccent,
              fontSize: 20,
              enabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
