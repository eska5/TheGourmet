import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/AlphabetScrollPage.dart';

class MealCatalog extends StatefulWidget {
  const MealCatalog({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<MealCatalog> {
  TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog dostępnych potraw'),
        backgroundColor: Colors.deepPurpleAccent,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.indigo[50],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.indigo[50],
      body: AlphabetScrollPage(
        items: [
          "Brokuł",
          "Sałatka cezar",
          "Marchewka",
          "Sernik",
          "Skrzydełka kurczaka",
          "Tort czekoladowy",
          "Babeczki",
          "Winniczki",
          "Frytki",
          "Hamburger",
          "Hot dog",
          "Lody",
          "Lasagne",
          "Omlet",
          "Naleśniki",
          "Pizza",
          "Żeberka",
          "Jajecznica",
          "Zupa",
          "Spaghetti bolognese",
          "Spaghetti carbonara",
          "Stek",
          "Sushi",
          "Tiramisu",
          "Gofry",
        ],
        onClickedItem: (String value) {},
      ),
    );
  }
}
