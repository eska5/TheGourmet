import 'dart:async';
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
import 'package:path/path.dart' as path;

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

String responseTitle = "";
String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

//TEMPORARY
final GlobalKey<State> _LoaderDialog2 = GlobalKey<State>();

class LoaderDialog2 {
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
                        child: Text(responseTitle,
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
                                context, _LoaderDialog2.currentContext),
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
  final GlobalKey<State> _LoaderDialog2 = GlobalKey<State>();

  Future pickImage(ImageSource source) async {
    //WEB
    if (kIsWeb) {
      try {
        final image = await ImagePicker()
            .pickImage(source: source, maxWidth: 400, maxHeight: 400);
        if (image == null) return;
        bool isThePhotoFormatGood = false;
        if (path.extension(path.basename(image.path)) == ".jpg"
        || path.extension(path.basename(image.path)) == ".jpeg" 
        || path.extension(path.basename(image.path)) == ".png") {
          isThePhotoFormatGood = true;
        }
        if (!validateFileExtension(image) || !isThePhotoFormatGood) {
          //TODO Make a popcard communicating that GIFs are not allowed.
          responseTitle = "Wybrano niepoprawyny format";
          responseText1 = "Rozszerzenie twojego zdjęcia jest ";
          responseText2 = "niepoprawne";
          responseText3 = ". Akceptowane formaty : jpg, jpeg, png";
          responseColor = "Colors.red";
          LoaderDialog2.showLoadingDialog(context, _LoaderDialog2);
          return;
        }
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
        bool isThePhotoFormatGood = false;
        if (path.extension(path.basename(image.path)) == ".jpg"
        || path.extension(path.basename(image.path)) == ".jpeg" 
        || path.extension(path.basename(image.path)) == ".png") {
          isThePhotoFormatGood = true;
        }
        if (!validateFileExtension(image) || !isThePhotoFormatGood) {
          //TODO Make a popcard communicating that GIFs are not allowed.
          responseTitle = "Wybrano niepoprawyny format";
          responseText1 = "Rozszerzenie twojego zdjęcia jest ";
          responseText2 = "niepoprawne";
          responseText3 = ". Akceptowane formaty : jpg, jpeg, png";
          responseColor = "Colors.red";
          LoaderDialog2.showLoadingDialog(context, _LoaderDialog2);
          return;
        }
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
      
      try{
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      ).timeout(Duration(seconds: 5));

      int statusCode = response.statusCode;
      String responseBody = response.body;

      setState(() {
        Navigator.pop(context, _LoaderDialog.currentContext);
        modelOutput = json.decode(response.body);
      });
      } on SocketException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, niewłaściwy adres serwera !";
        responseColor = "Colors.red";
        Navigator.pop(context, _LoaderDialog2.currentContext);
        LoaderDialog2.showLoadingDialog(context, _LoaderDialog);
      } on TimeoutException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, przekroczono limit czasu !";
        responseColor = "Colors.red";
        Navigator.pop(context, _LoaderDialog2.currentContext);
        LoaderDialog2.showLoadingDialog(context, _LoaderDialog);
      }
      //LoaderDialog.showLoadingDialog(context, _LoaderDialog);
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
