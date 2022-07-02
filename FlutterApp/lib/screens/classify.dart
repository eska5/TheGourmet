import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/functions/func.dart' as func;
import 'package:new_ui/screens/catalog.dart';
import 'package:new_ui/screens/result.dart';
import 'package:page_indicator/page_indicator.dart';

import '../components/result_card.dart';

class ClassifyImage extends StatefulWidget {
  const ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _AddImageState();
}

class _AddImageState extends State<ClassifyImage> {
  String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

  TextEditingController inputText = TextEditingController();
  TextEditingController recognizedMeal =
      TextEditingController(text: "Tutaj pojawi się wynik");

  // Response popUp variables
  String responseTitle = "";
  String responseText1 = "";
  String responseText2 = "";
  String responseText3 = "";
  String responseColor = "";

  // ignore: non_constant_identifier_names
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

  void _navigateAndDisplaySelection(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModelResult()),
    );
  }

  void _navigateAndDisplaySelection2(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MealCatalog()),
    );
  }

  void pickImage(ImageSource source) async {
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
          showTopSnackBarCustomError(context, responseTitle);
          return;
        }

        final imageTemporary = await image.readAsBytes();
        globals.isClassifyReady = true;
        setState(() => globals.webImageClassify = imageTemporary);
        categorizeThePhoto();
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
          showTopSnackBarCustomError(context, responseTitle);
          return;
        }

        final imageTemporary = File(image.path);
        globals.isClassifyReady = true;
        setState(() => globals.mobileImageClassify = imageTemporary);
        categorizeThePhoto();
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
    }
  }

  void categorizeThePhoto() async {
    try {
      final uri = Uri.parse("https://gourmetapp.net/classify");
      final headers = {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      };

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

      try {
        var response = await http
            .post(
              uri,
              headers: headers,
              body: jsonBody,
              encoding: encoding,
            )
            .timeout(const Duration(seconds: 30));

        setState(() {
          // Changing variables in global Tiles
          for (int i = 0; i < 3; i++) {
            resultCards[i].mealName = json.decode(response.body)[i * 2];
            resultCards[i].mealDescription = json.decode(response.body)[i * 2];
            resultCards[i].mealProbability =
                double.parse(json.decode(response.body)[i * 2 + 1]) * 100;
          }
          globals.mealClassified = true;
        });
      } on SocketException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, niewłaściwy adres serwera !";
        responseColor = "Colors.red";
        showTopSnackBarCustomError(
            context, (responseText1 + responseText2 + responseText3));
      } on TimeoutException {
        responseTitle = "Status przesłania";
        responseText1 = "Zdjęcie ";
        responseText2 = "nie zostało ";
        responseText3 = "rozpoznane, przekroczono limit czasu !";
        responseColor = "Colors.red";
        showTopSnackBarCustomError(
            context, (responseText1 + responseText2 + responseText3));
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to send to server: $e');
      }
    }
  }

  final PageController controller = PageController();
  GlobalKey<PageContainerState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Shows that we are in classify
    globals.isClassify = true;
    return PageIndicatorContainer(
      indicatorSelectorColor: Colors.blue.shade400,
      indicatorColor: Colors.grey,
      key: key,
      padding:
          const EdgeInsets.only(top: 100.0, bottom: 0, left: 0.0, right: 0.0),
      align: IndicatorAlign.top,
      length: 2,
      indicatorSpace: 20.0,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const Icon(Icons.add_box_rounded, size: 29),
              title: const Text('Co masz na talerzu?',
                  style: TextStyle(fontSize: 22)),
              backgroundColor: Colors.indigo,
            ),
            backgroundColor: Colors.indigo[50],
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _navigateAndDisplaySelection2(context),
              backgroundColor: Colors.deepPurpleAccent,
              splashColor: Colors.deepPurpleAccent,
              label: const Text('Katalog'),
              icon: const Icon(Icons.format_list_bulleted_rounded),
            ),
            body: ListView(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 13.0, bottom: 13.0, top: 45),
              children: [
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: <Widget>[
                    Center(
                        // Display image
                        child: func.buildPicture()),
                    Positioned(
                      right: 65,
                      top: -15,
                      child: PopupMenuButton(
                        offset: Offset(19, 216),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: Colors.deepPurpleAccent,
                        initialValue: 1,
                        child: Container(
                          width: 230,
                          height: 230,
                          decoration: BoxDecoration(
                              color: Color(0xFFFE9901).withOpacity(0.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: () => pickImage(ImageSource.gallery),
                            padding: const EdgeInsets.only(right: 40, left: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_library_rounded,
                                  size: 28,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  " Wybierz zdjęcie",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () => pickImage(ImageSource.camera),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  size: 28,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "     Zrób zdjęcie  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
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
                  // Classify the meal button
                  child: enabledButton(
                    title: 'Dalej    ',
                    icon: Icons.arrow_forward_rounded,
                    onClicked: () => controller.animateToPage(1,
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeOutQuint),
                    backgroundColor: Colors.blue.shade400,
                    fontSize: 20,
                    enabled: true,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: PopupMenuButton(
                    offset: Offset(19, 67),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: Colors.deepPurpleAccent,
                    initialValue: 1,
                    child: Container(
                      width: 245,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFFFE9901),
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Załaduj zdjęcie",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () => pickImage(ImageSource.gallery),
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              size: 28,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              " Wybierz zdjęcie",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => pickImage(ImageSource.camera),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 28,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "     Zrób zdjęcie  ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const Icon(Icons.fastfood_rounded, size: 29),
              title:
                  const Text('Zobacz wyniki', style: TextStyle(fontSize: 22)),
              backgroundColor: Colors.indigo,
            ),
            backgroundColor: Colors.indigo[50],
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _navigateAndDisplaySelection2(context),
              backgroundColor: Colors.deepPurpleAccent,
              splashColor: Colors.deepPurpleAccent,
              label: const Text('Katalog'),
              icon: const Icon(Icons.format_list_bulleted_rounded),
            ),
            body: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, bottom: 13.0, top: 50),
                children: [
                  Center(child: func.buildPicture()),
                  const SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        createCard(cardDetails1),
                        createCard(cardDetails2),
                        createCard(cardDetails3),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 125,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: generalButton(
                        title: "Złe wyniki",
                        icon: Icons.report_rounded,
                        color: const Color(0xFFDC143C),
                        onClicked: () =>
                            _navigateAndDisplaySelection2(context)),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
