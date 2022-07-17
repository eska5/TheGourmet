import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_ui/resources/common/page_indicator.dart';

import '../../common/button.dart';
import '../methods.dart';
import '../result_card.dart';

class ResultScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? pickedImage;

  const ResultScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreen();
}

class _ResultScreen extends State<ResultScreen> {
  void setResultCards(BuildContext context) async {
    //Set<Map<String, dynamic>> results = await categorizeThePhoto(context);
    setState(() {
      print("got the results");
      // int i =0;
      // for (var entry in results) {
      //   resultCards[i].mealName = entry["name"];
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.fastfood_rounded, size: 29),
        title: const Text('Zobacz wyniki', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigateToCatalog(context),
        backgroundColor: Colors.deepPurpleAccent,
        splashColor: Colors.deepPurpleAccent,
        label: const Text('Katalog'),
        icon: const Icon(Icons.format_list_bulleted_rounded),
      ),
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, bottom: 13.0, top: 50),
          children: [
            classifyPageIndicator(controller: widget.controller, count: 2),
            const SizedBox(
              height: 50,
            ),
            //Center(child: imageContainer()),  #TODO CHANGE IT TO NEW WIDGET
            const SizedBox(
              height: 50,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  createCard(resultCards[0]),
                  createCard(resultCards[1]),
                  createCard(resultCards[2]),
                ],
              ),
            ),
            const SizedBox(
              height: 125,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: generalButton(
                  title: "Złe wyniki",
                  icon: Icons.report_rounded,
                  color: const Color(0xFFDC143C),
                  onClicked: () => navigateToReportScreen(context)),
            ),
          ]),
    );
  }
}
