import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/classify_screen/result_card.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';
import 'package:new_ui/resources/common/snack_bars.dart';

import '../../screens/catalog.dart';
import '../../screens/report.dart';
import '../common/func.dart';

String responseBody = "";

void categorizeThePhoto(BuildContext context, Uint8List? bytes) async {
  ResultScreen.isClassified.value = false;
  resultCards = [
    CardDetails(color: Colors.blue.shade300, cardNumber: 1),
    CardDetails(color: Colors.blue.shade300, cardNumber: 2),
    CardDetails(color: Colors.blue.shade300, cardNumber: 3)
  ];
  if (kDebugMode) {
    print(ResultScreen.isClassified.value);
  }
  final uri = Uri.parse("https://gourmetapp.net/classify");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

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
    responseBody = response.body;
    for (int i = 0; i < 3; i++) {
      resultCards[i].mealName = json.decode(responseBody)[i * 2];
      resultCards[i].mealDescription = json.decode(responseBody)[i * 2];
      resultCards[i].mealProbability =
          double.parse(json.decode(responseBody)[i * 2 + 1]) * 100;
    }
    ResultScreen.isClassified.value = true;
    if (kDebugMode) {
      print(ResultScreen.isClassified.value);
      print(resultCards[0].mealName);
    }
    if (resultCards[0].mealProbability < 50) {
      showWarningMessage(context, "Wyniki mogą być niedokładne");
    }
  } on HttpException {
    showErrorMessage(context, "Wystąpił błąd w komunikacji z serwerem");
  }
}

Future<Uint8List?> pickImage(ImageSource source, BuildContext context) async {
  Uint8List? imageTemporary;
  //WEB
  if (kIsWeb) {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (image == null) return null;

      if (!validateFileExtension(image)) {
        showErrorMessage(context, "Wybrano niepoprawny format zdjęcia");
        return null;
      }

      imageTemporary = await image.readAsBytes();
      categorizeThePhoto(context, imageTemporary);
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
        showErrorMessage(context, "Wybrano niepoprawny format zdjęcia");
        return null;
      }

      imageTemporary = await image.readAsBytes();
      categorizeThePhoto(context, imageTemporary);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  return imageTemporary;
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

void getMoreResults(Function onClick) {
  // print(responseBody[3]);
  for (int i = 3; i < 5; i++) {
    resultCards.add(CardDetails(color: Colors.blue.shade300, cardNumber: 4));
    // TODO MAKE BACKEND RETURN ALL THE RESULTS
    // resultCards[i].mealName = json.decode(responseBody)[i * 2];
    // resultCards[i].mealDescription = json.decode(responseBody)[i * 2];
    // resultCards[i].mealProbability =
    //     double.parse(json.decode(responseBody)[i * 2 + 1]) * 100;
  }
  onClick();
}
