import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../common/suggestions.dart';

class LabelMealScreen extends StatefulWidget {
  final PageController controller;
  static String mealLabel = "";
  static TextEditingController inputText = TextEditingController();

  const LabelMealScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LabelMealScreen> createState() => _LabelMealScreen();
}

class _LabelMealScreen extends State<LabelMealScreen> {
  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("label_meal rebuild!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.add_box_rounded, size: 29),
        title: const Text('Nazwij potrawę', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => widget.controller.animateToPage(0,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),
              backgroundColor: Colors.green,
              splashColor: Colors.green,
              label: const Text('Wróć'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => widget.controller.animateToPage(2,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),
              backgroundColor: Colors.blue.shade400,
              splashColor: Colors.blue.shade400,
              label: const Text('Dalej'),
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
      body: ShowUpAnimation(
        animationDuration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        direction: Direction.vertical,
        offset: 0,
        child: ListView(
          padding: const EdgeInsets.only(
              left: 13.0, right: 13.0, bottom: 13.0, top: 45),
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 22, right: 22, bottom: 10),
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
                  controller: LabelMealScreen.inputText,
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
                  LabelMealScreen.inputText.text = potrawa.suggest;
                  TextField(
                    controller: LabelMealScreen.inputText,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'podaj nazwe potrawy',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
