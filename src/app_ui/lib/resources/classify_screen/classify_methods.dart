import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/resources/classify_screen/result_card.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/classify_results.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/detection_results.dart';

import '../common/snack_bars.dart';
import 'sub_screens/report.dart';

String classifyResponse = "";
int classifyCardIndex = 0;

void sendClassifyRequest(BuildContext context, Uint8List? bytes) async {
  ResultScreen.isClassified.value = false;
  classifyCardIndex = 0;
  classifyResultCards = [
    CardDetails(color: Colors.blue.shade300, cardNumber: 1),
    CardDetails(color: Colors.blue.shade300, cardNumber: 2),
    CardDetails(color: Colors.blue.shade300, cardNumber: 3)
  ];
  if (kDebugMode) {
    print(ResultScreen.isClassified.value);
  }
  final uri = Uri.parse("https://gourmetapp.net/api/v1/classify");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Map<String, dynamic> body = {'image': base64Encode(bytes!)};
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
    classifyResponse = response.body;
    setDataInCards(3, true, response.body);
    ResultScreen.isClassified.value = true;
    if (kDebugMode) {
      print(ResultScreen.isClassified.value);
      print(classifyResultCards[0].mealName);
    }
    if (classifyResultCards[0].mealProbability < 50) {
      showWarningMessage(context, "Wyniki mogą być niedokładne");
    }
  } on HttpException {
    showErrorMessage(context, "Wystąpił błąd w komunikacji z serwerem");
  }
}

void sendDetectionRequest(BuildContext context, Uint8List? bytes) async {
  ResultScreen.isDetected.value = false;
  detectionResultCards = [
    CardDetails(color: Colors.blue.shade300, cardNumber: 1)
  ];
  DetectionResultScreen.detectedImage = null;
  if (kDebugMode) {
    print(ResultScreen.isClassified.value);
  }
  final uri = Uri.parse("https://gourmetapp.net/api/v1/detection");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Map<String, dynamic> body = {'image': base64Encode(bytes!)};
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
    ResultScreen.isDetected.value = true;
    int detectedMeals = json.decode(response.body).length - 1;
    for (int i = 1; i < detectedMeals; i++) {
      detectionResultCards
          .add(CardDetails(color: Colors.blue.shade300, cardNumber: i + 1));
    }
    DetectionResultScreen.detectedImage =
        base64Decode(Map.from(json.decode(response.body)[0])["result_image"]);
    setDataInCards(detectedMeals, false, response.body);
    if (kDebugMode) {
      print("detection performed");
    }
  } on HttpException {
    showErrorMessage(context, "Wystąpił błąd w komunikacji z serwerem");
  }
}

void navigateToReportScreen(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ReportBadResult()),
  );
}

void setDataInCards(int amount, bool classification, String data) {
  if (classification) {
    for (int i = classifyCardIndex; i < classifyCardIndex + amount; i++) {
      classifyResultCards[i].mealName = Map.from(json.decode(data)[i])["name"];
      classifyResultCards[i].mealProbability =
          double.parse(Map.from(json.decode(data)[i])["certainty"]) * 100;
      var mealCalories = Map.from(json.decode(data)[i])["calories"];
      var mealAllergens = Map.from(json.decode(data)[i])["allergens"];
      classifyResultCards[i].mealDescription =
          "Szacowane kalorie na 100g: ${mealCalories} kcal\nMożliwe alergeny: ${mealAllergens.toString().replaceAll(RegExp(r'[\[\]]'), '')}";
    }
    classifyCardIndex += amount;
  } else {
    if (amount == 0) {
      detectionResultCards[0].mealName = "Nie wykryto potrawy";
    }
    for (int i = 0; i < amount; i++) {
      detectionResultCards[i].mealName =
          Map.from(json.decode(data)[i + 1])["name"];
      detectionResultCards[i].mealProbability =
          double.parse(Map.from(json.decode(data)[i + 1])["certainty"]) * 100;
      var mealCalories = Map.from(json.decode(data)[i + 1])["calories"];
      var mealAllergens = Map.from(json.decode(data)[i + 1])["allergens"];
      detectionResultCards[i].mealDescription =
          "Szacowane kalorie na 100g: ${mealCalories} kcal\nMożliwe alergeny: ${mealAllergens.toString().replaceAll(RegExp(r'[\[\]]'), '')}";
    }
  }
}

void getMoreResults(int amount, Function onClick, BuildContext context) {
  if (classifyCardIndex < 7) {
    for (int i = classifyCardIndex; i < classifyCardIndex + amount; i++) {
      classifyResultCards
          .add(CardDetails(color: Colors.blue.shade300, cardNumber: 4));
    }
    setDataInCards(amount, true, classifyResponse);
    onClick();
  } else {
    showErrorMessage(context, "Osiągnięto limit propozycji");
  }
}

Future sendBadResultRequest(BuildContext context, Uint8List? image,
    String goodLabel, String badLabel) async {
  final uri = Uri.parse("https://gourmetapp.net/api/v1/badresult");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  String base64Image = base64Encode(image!);
  Map<String, dynamic> body = {
    'modeloutput': badLabel,
    'useroutput': goodLabel,
    'mealPhoto': base64Image
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  print(goodLabel + " " + badLabel);
  if (goodLabel == "") {
    showErrorMessage(context, "Niepoprawne dane");
  } else {
    try {
      var response = await http
          .post(
            uri,
            headers: headers,
            body: jsonBody,
            encoding: encoding,
          )
          .timeout(Duration(seconds: 1));

      int statusCode = response.statusCode;

      if (statusCode == 500) {
        showErrorMessage(context, "Wystąpił błąd w komunikacji z serwerem");
      } else if (statusCode == 201) {
        showSuccessMessage(context, "Pomyślnie wysłano zgłoszenie");
      } else if (statusCode == 400) {
        showErrorMessage(context, "Niepoprawne dane");
      }
    } on HttpException {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
