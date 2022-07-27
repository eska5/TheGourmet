import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../screens/suggestions.dart';

void navigateToSuggestions(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MealSuggestions()),
  );
}

Future sendToServer() async {
  final uri = Uri.parse("https://gourmetapp.net/meals");
  final headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };
  Uint8List? bytes;
  // Response when photo or name were not given
  // if (!validateRequest("Add")) {
  //   responseTitle = "Nie wybrano zdjęcia lub podpisu potrawy";
  //   responseText1 = "Zanim dodasz zdjęcie potrawy, ";
  //   responseText2 = "";
  //   responseText3 =
  //   "załaduj zdjęcie z galerii lub aparatu i upewnij się, że dodano nazwę potrawy";
  //   responseColor = "Colors.red";
  //   showErrorMessage(context, responseTitle);
  //   return;

  // if (kIsWeb) {
  //   bytes = globals.webImageAdd;
  // } else {
  //   bytes = File(globals.mobileImageAdd!.path).readAsBytesSync();
  // }
  //
  // String base64Image = base64Encode(bytes!);
  // Map<String, dynamic> body = {
  //   'mealName': globals.mealTag,
  //   'mealPhoto': base64Image
  // };
  String jsonBody = json.encode("dupa");
  final encoding = Encoding.getByName('utf-8');

  // Try catch error handling
  try {
    var response = await http
        .post(
          uri,
          headers: headers,
          body: jsonBody,
          encoding: encoding,
        )
        .timeout(const Duration(seconds: 1));

    int statusCode = response.statusCode;
    String responseBody = response.body;
    if (kDebugMode) {
      print(responseBody);
      print(statusCode);
      print("OK");
    }
    // Snackbar Response <for user>
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print('Failed to send to server: $e');
    }
  }
}
