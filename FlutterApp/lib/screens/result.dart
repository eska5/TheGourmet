import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:new_ui/popupcard/Card.dart';
import 'package:new_ui/screens/report.dart';

class ModelResult extends StatefulWidget {
  const ModelResult({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<ModelResult> {
  TextEditingController inputText = TextEditingController();
  bool _customTileExpanded = false;

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
            Center(
              child: globals.webImageClassify == null &&
                      globals.mobileImageClassify == null
                  ? Image.asset('assets/diet.png', width: 200, height: 200)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: kIsWeb
                          ? Image.memory(
                              globals.webImageClassify!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              globals.mobileImageClassify!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )),
            ),
            const SizedBox(
              height: 50,
            ),
            SingleChildScrollView(
              child: Container(
                  child: new Column(
                children: [
                  createCard(globals.tile1),
                  createCard(globals.tile2),
                  createCard(globals.tile3),
                ],
              )),
            ),
            const SizedBox(
              height: 125,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SubmitErrorButton(
                  title: "Złe wyniki",
                  icon: Icons.report_rounded,
                  errorColor: globals.ErrorColor,
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
