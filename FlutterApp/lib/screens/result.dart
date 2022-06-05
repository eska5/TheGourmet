import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/popupcard/add_todo_button2.dart';
import 'package:new_ui/components/globals.dart' as globals;
import 'package:new_ui/components/button.dart';
import 'package:new_ui/screens/report.dart';
import 'package:universal_platform/universal_platform.dart';


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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child:AddTodoButton2(key: Key("1"),chance: globals.modelChance1, mobileImageCliassify: UniversalPlatform.isWeb?globals.webImageClassify :globals.mobileImageClassify, data: "Tresc tutaj", modelOutput: "1. " + globals.modelOutput1, chosenColor: globals.firstColor,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:AddTodoButton2(key: Key("2"),chance: globals.modelChance2, mobileImageCliassify: UniversalPlatform.isWeb?globals.webImageClassify :globals.mobileImageClassify, data: "Tresc tutaj", modelOutput: "2. " + globals.modelOutput2, chosenColor: globals.secondColor,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:AddTodoButton2(key: Key("3"),chance: globals.modelChance3, mobileImageCliassify: UniversalPlatform.isWeb?globals.webImageClassify :globals.mobileImageClassify, data: "Tresc tutaj", modelOutput: "3. " + globals.modelOutput3, chosenColor: globals.thirdColor),
          ),
          const SizedBox(
            height: 300,
          ),
          Align(alignment: Alignment.bottomCenter ,
          child: SubmitErrorButton(title: "Złe wyniki", icon: Icons.report_rounded,errorColor: globals.ErrorColor, onClicked: () => _navigateAndDisplaySelection2(context)),
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