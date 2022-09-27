import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:new_ui/resources/add_screen/sub_screens/label_meal.dart';
import 'package:new_ui/resources/common/button.dart';
import 'package:new_ui/resources/common/snack_bars.dart';

import '../resources/add_screen/sub_screens/load_image.dart';
import '../resources/common/suggestions.dart';

String responseTitle = "";
String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

class ReportBadResult extends StatefulWidget {
  const ReportBadResult({Key? key}) : super(key: key);

  @override
  _Screen2State2 createState() => _Screen2State2();
}

class _Screen2State2 extends State<ReportBadResult> {
  TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zgłoś potrawę'),
        backgroundColor: Colors.green[600],
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.indigo[50],
          ),
          onTap: () {
            String name = inputText.text;
            if (kDebugMode) {
              print("passed to AddMeal screen : $name");
            }
            Navigator.pop(context, name);
          },
        ),
      ),
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 22, left: 22, right: 22, bottom: 10),
          child: TypeAheadField<Suggestions?>(
            hideSuggestionsOnKeyboardHide: true,
            debounceDuration: const Duration(milliseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: 'Podaj nazwę potrawy',
              ),
              controller: this.inputText,
            ),
            suggestionsCallback: SuggestionsApi.getSuggestionsSuggestions,
            itemBuilder: (context, Suggestions? suggestion) {
              final hint = suggestion;
              return ListTile(
                title: Text(hint!.suggest.toString()),
              );
            },
            noItemsFoundBuilder: (context) => Container(
              height: 40,
              child: const Center(
                child: Text(
                  'Brak potraw w bazie',
                ),
              ),
            ),
            onSuggestionSelected: (Suggestions? suggestion) {
              final potrawa = suggestion!;
              inputText.text = potrawa.suggest;
              TextField(
                controller: inputText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'podaj nazwe potrawy',
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 400,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: generalButton(
              title: "Wyslij",
              width: 245,
              height: 60,
              icon: Icons.send_rounded,
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              onClicked: () => sendReport(
                  context,
                  AddLoadImageScreen.pickedImage,
                  LabelMealScreen.mealLabel,
                  inputText.text)),
        ),
      ]),
    );
  }
}

Future sendReport(BuildContext context, Uint8List? image, String goodLabel,
    String badLabel) async {
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
