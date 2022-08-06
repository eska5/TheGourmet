import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/resources/classify_screen/result_card.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';

import '../../screens/report.dart';
import '../common/snack_bars.dart';

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
