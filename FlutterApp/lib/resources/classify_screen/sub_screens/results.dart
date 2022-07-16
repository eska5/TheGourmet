import 'package:flutter/material.dart';
import 'package:new_ui/components/page_indicator.dart';

import '../../../components/button.dart';
import '../../../components/result_card.dart';
import '../functions.dart';

Widget modelResultsScreen({
  required BuildContext context,
  required PageController controller,
}) =>
    Scaffold(
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
            classifyPageIndicator(controller: controller),
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
                  createCard(cardDetails1),
                  createCard(cardDetails2),
                  createCard(cardDetails3),
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
