import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/resources/classify_screen/result_card.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/classify_results.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/detection_results.dart';

import '../../screens/report.dart';
import '../common/snack_bars.dart';

String responseBody = "";
int cardIndex = 0;

void sendClassifyRequest(BuildContext context, Uint8List? bytes) async {
  ResultScreen.isClassified.value = false;
  cardIndex = 0;
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
    setDataInCards(3);
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
  detectionResultCards = [];
  DetectionResultScreen.detectedImage = null;
  if (kDebugMode) {
    print(ResultScreen.isClassified.value);
  }
  final uri = Uri.parse("https://gourmetapp.net/api/v1/detection");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Map<String, dynamic> body = {'img_for_detection': base64Encode(bytes!)};
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
    ResultScreen.isDetected.value = true;
    int detectedMeals = json.decode(responseBody).length - 1;
    for (int i = 0; i < detectedMeals; i++) {
      detectionResultCards
          .add(CardDetails(color: Colors.blue.shade300, cardNumber: i + 1));
    }
    DetectionResultScreen.detectedImage = base64Decode(
        Map.from(json.decode(responseBody)[0])["detection_result"]);
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

void setDataInCards(int amount) {
  for (int i = cardIndex; i < cardIndex + amount; i++) {
    classifyResultCards[i].mealName =
        Map.from(json.decode(responseBody)[i])["name"];
    classifyResultCards[i].mealProbability =
        double.parse(Map.from(json.decode(responseBody)[i])["certainty"]) * 100;

    if (Map.from(json.decode(responseBody)[i])["description"] !=
        "Brak danych") {
      Map description =
          Map.from(Map.from(json.decode(responseBody)[i])["description"]);
      classifyResultCards[i].mealDescription =
          "Szacowane kalorie na 100g: ${description['calories']} kcal\nMożliwe alergeny: ${description['allergens'].toString().replaceAll(RegExp(r'[\[\]]'), '')}";
    } else {
      classifyResultCards[i].mealDescription =
          Map.from(json.decode(responseBody)[i])["description"];
    }
  }
  cardIndex += amount;
}

void getMoreResults(int amount, Function onClick, BuildContext context) {
  if (cardIndex < 7) {
    for (int i = cardIndex; i < cardIndex + amount; i++) {
      classifyResultCards
          .add(CardDetails(color: Colors.blue.shade300, cardNumber: 4));
    }
    setDataInCards(amount);
    onClick();
  } else {
    showErrorMessage(context, "Osiągnięto limit propozycji");
  }
}
