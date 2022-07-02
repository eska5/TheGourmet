import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/result_card.dart';
import 'package:new_ui/functions/func.dart' as func;
import 'package:new_ui/screens/report.dart';

import '../components/result_card.dart';

class ModelResult extends StatefulWidget {
  const ModelResult({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<ModelResult> {
  TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wróć do ekranu głównego'),
        backgroundColor: Colors.blue[400],
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20,
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
      body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, bottom: 13.0, top: 50),
          children: [
            Center(child: func.buildPicture()),
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
                  onClicked: () => _navigateAndDisplaySelection2(context)),
            ),
          ]),
    );
  }
}

void _navigateAndDisplaySelection2(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ModelResult2()),
  );
}
