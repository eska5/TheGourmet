import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Wyniki modelu'),
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
        //CONTENT OF THE SCREEN
      ]),
    );
  }
}
