import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../components/suggestions.dart';

class MealSuggestions extends StatefulWidget {
  const MealSuggestions({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<MealSuggestions> {
  TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zapisz i wyjdź'),
        backgroundColor: Colors.indigo,
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
        Padding(
          padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: 15), //apply padding to all four sides
          child: SizedBox(
            width: 235, // <-- Your width
            height: 60, // <-- Your height
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                onPrimary: Colors.white,

                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                //minimumSize: const Size(40, 60),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app_outlined, size: 28),
                  const SizedBox(width: 10),
                  Text("Zapisz i wróć"),
                ],
              ),
              onPressed: () => Navigator.pop(context, inputText.text),
            ),
          ),
        )
      ]),
    );
  }
}
