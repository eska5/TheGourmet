import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:new_ui/resources/common/button.dart';

import '../../../screens/classify.dart';
import '../../common/suggestions.dart';
import '../classify_methods.dart';
import '../result_card.dart';
import 'load_image.dart';

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
        title: const Text('Podaj poprawny wynik'),
        backgroundColor: const Color(0xFFFE9901),
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
          height: 300,
        ),
        Center(
          child: SizedBox(
            height: 45,
            width: 226,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.deepPurpleAccent,
                onPrimary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.info_outline_rounded, size: 28),
                  SizedBox(width: 10),
                  Text("Czemu to służy?"),
                ],
              ),
              onPressed: () => displayDialog(context),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: generalButton(
              title: "Wyslij",
              width: 245,
              height: 60,
              icon: Icons.send_rounded,
              color: Colors.green.shade600,
              textColor: Colors.white,
              onClicked: () => sendBadResultRequest(
                context,
                ClassifyLoadImageScreen.pickedImage,
                inputText.text,
                ClassifyImage.isClassificationSet == true
                    ? classifyResultCards[0].mealName
                    : detectionResultCards[0].mealName,
              ),
            )),
      ]),
    );
  }
}

Future<void> displayDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Czemu to służy?'),
        content: const Text(
            'Jeśli powiesz nam co tak naprawdę jest na talerzu to zapiszemy twoje zgłoszenie, a następnie użyjemy do ulepszenia modelu w przyszłych treningach'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Rozumiem'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
