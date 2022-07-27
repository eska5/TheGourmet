import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:new_ui/resources/classify_screen/result_card.dart';
import 'package:new_ui/resources/common/button.dart';
import 'package:new_ui/resources/common/globals.dart' as globals;
import 'package:new_ui/resources/common/snack_bars.dart';
import 'package:universal_platform/universal_platform.dart';

import '../resources/common/methods.dart';
import '../resources/common/suggestions.dart';

String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION

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
              icon: Icons.send_rounded,
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              onClicked: () => wyslijReportiWroc(context, this.inputText.text)),
        ),
      ]),
    );
  }
}

Future wyslijReportiWroc(context, inputText2) async {
  final GlobalKey<State> _LoaderDialog = GlobalKey<State>();
  globals.ReportMealName = inputText2;
  try {
    if (!UniversalPlatform.isWeb) {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              host == 'localhost:5000';
      final http = IOClient(ioc);
    }

    final uri = Uri.parse(domain + "/badresult");
    final headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    };
    Uint8List? bytes;
    print(!validateRequest("Report"));
    if (!validateRequest("Report")) {
      responseTitle = "Nie podano poprawnej nazwy potrawy !";
      responseText1 = "";
      responseText2 = "";
      responseText3 = "Upewnij się, że dodano nazwę potrawy";
      responseColor = "Colors.red";
      showErrorMessage(context, responseTitle);
      // LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
      //     responseText1, responseText2, responseText3, responseColor);
      return;
    }

    if (kIsWeb) {
      bytes = globals.webImageClassify;
    } else {
      bytes = File(globals.mobileImageClassify!.path).readAsBytesSync();
    }

    String base64Image = base64Encode(bytes!);
    Map<String, dynamic> body = {
      'modeloutput': resultCards[0].mealName,
      'useroutput': globals.ReportMealName,
      'mealPhoto': base64Image
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    try {
      //TO DO Make a Catch for a error when user is posting a photo
      var response = await http
          .post(
            uri,
            headers: headers,
            body: jsonBody,
            encoding: encoding,
          )
          .timeout(Duration(seconds: 1));

      int statusCode = response.statusCode;
      String responseBody = response.body;
      if (kDebugMode) {
        print(responseBody);
        print(statusCode);
        print("OK");
      }
      responseTitle = "Status przesłania";
      if (statusCode == 200) {
        responseText1 = "Zgłoszenie zostało ";
        responseText2 = "poprawnie ";
        responseText3 = "wysłane, odebrane i zapisane !";
        responseColor = "Colors.green";
      }
    } on TimeoutException {
      responseTitle = "Status przesłania";
      responseText1 = "Zdjęcie ";
      responseText2 = "nie zostało ";
      responseText3 = "odebrane, przekroczono limit czasu !";
      responseColor = "Colors.red";
    } on SocketException {
      responseTitle = "Status przesłania";
      responseText1 = "Zdjęcie ";
      responseText2 = "nie zostało ";
      responseText3 = "odebrane, niewłaściwy adres serwera !";
      responseColor = "Colors.red";
    }
    responseColor == "Colors.red"
        ? showErrorMessage(
            context, (responseText1 + responseText2 + responseText3))
        : showSuccessMessage(
            context, (responseText1 + responseText2 + responseText3));
    // LoaderDialog.showLoadingDialog(context, _LoaderDialog, responseTitle,
    //     responseText1, responseText2, responseText3, responseColor);
    //Navigator.pop(context);
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print('Failed to send to server: $e');
    }
  }
}
