import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/components/globals.dart' as globals;

import '../../components/result_card.dart';
import '../../functions/func.dart';
import '../../screens/catalog.dart';
import '../../screens/report.dart';

void categorizeThePhoto(BuildContext context) async {
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

  Map<String, dynamic> body = {'mealPhoto': base64Encode(bytes!)};
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

    for (int i = 0; i < 3; i++) {
      resultCards[i].mealName = json.decode(response.body)[i * 2];
      resultCards[i].mealDescription = json.decode(response.body)[i * 2];
      resultCards[i].mealProbability =
          double.parse(json.decode(response.body)[i * 2 + 1]) * 100;
    }
    globals.mealClassified = true;
  } on HttpException {
    showTopSnackBarCustomError(
        context, "Wystąpił błąd w komunikacji z serwerem");
  }
}

Future<Uint8List?> pickImage(ImageSource source, BuildContext context) async {
  final Uint8List? imageTemporary;
  //WEB
  if (kIsWeb) {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (image == null) return null;

      if (!validateFileExtension(image)) {
        // responseTitle = "Wybrano niepoprawyny format";
        // responseText1 = "Rozszerzenie twojego zdjęcia jest ";
        // responseText2 = "niepoprawne";
        // responseText3 = ". Akceptowane formaty : jpg, jpeg, png";
        // responseColor = "Colors.red";
        showTopSnackBarCustomError(context, "Wybrano niepoprawyny format");
        //return;
      }

      final imageTemporary = await image?.readAsBytes();
      globals.isClassifyReady = true;
      globals.webImageClassify = imageTemporary;
      return imageTemporary;
      // categorizeThePhoto(context);
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
      if (image == null) return null;

      if (!validateFileExtension(image)) {
        showTopSnackBarCustomError(
            context, "Wybrano niepoprawyny format zdjęcia");
        return null;
      }

      final imageTemporary2 = File(image.path);
      imageTemporary = await image.readAsBytes();
      globals.isClassifyReady = true;
      globals.mobileImageClassify = imageTemporary2;
      return imageTemporary;
      //categorizeThePhoto(context);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
}

void navigateToCatalog(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MealCatalog()),
  );
}

void navigateToReportScreen(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ReportBadResult()),
  );
}
