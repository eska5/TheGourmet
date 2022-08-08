import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../common/snack_bars.dart';

Future sendMeal(BuildContext context, Uint8List? image, String label) async {
  final uri = Uri.parse("https://gourmetapp.net/api/v1/meals");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Map<String, dynamic> body;

  if (image == null) {
    body = {'mealName': label, 'mealPhoto': ""};
  } else {
    body = {'mealName': label, 'mealPhoto': json.encode(base64Encode(image!))};
  }

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
        .timeout(const Duration(seconds: 3));

    int statusCode = response.statusCode;

    if (statusCode == 500) {
      showErrorMessage(context, "Wystąpił błąd w komunikacji z serwerem");
    } else if (statusCode == 201) {
      showSuccessMessage(context, "Pomyślnie dodano zdjęcie");
    } else if (statusCode == 400) {
      showErrorMessage(context, "Niepoprawne dane");
    }
  } on HttpException {
    if (kDebugMode) {
      print("error");
    }
  }
}
