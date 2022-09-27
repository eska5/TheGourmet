import 'package:flutter/material.dart';

import '../resources/common/catalog_scroll_page.dart';

class MealCatalog extends StatefulWidget {
  static List<String> catalogBody = [];

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
            size: 32,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.indigo[50],
      body: AlphabetScrollPage(
        items: MealCatalog.catalogBody,
        onClickedItem: (String value) {},
      ),
    );
  }
}
