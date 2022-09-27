import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/resources/add_screen/sub_screens/label_meal.dart';
import 'package:new_ui/resources/common/button.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../add_methods.dart';
import 'load_image.dart';

class SummaryScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? pickedImage;

  const SummaryScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreen();
}

class _SummaryScreen extends State<SummaryScreen> {
  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("summary rebuild!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.add_box_rounded, size: 29),
        title: const Text('Podsumowanie', style: TextStyle(fontSize: 22)),
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
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),
              backgroundColor: Colors.green,
              splashColor: Colors.green,
              label: const Text('Wróć'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(
              height: 0,
            )
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
            Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent,
                      boxShadow: [
                        AddLoadImageScreen.pickedImage != null
                            ? const BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    0.0, 0.0), // shadow direction: bottom right
                              )
                            : const BoxShadow(color: Colors.transparent)
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: AddLoadImageScreen.pickedImage != null
                            ? Image.memory(
                                AddLoadImageScreen.pickedImage!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/diet.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                const SizedBox(
                  height: 220,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  alignment: Alignment.center,
                  //width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFFE9901),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.shade100,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(0.0, 0.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(LabelMealScreen.inputText.text,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              // Send the meal button
              child: generalButton(
                  title: "Wyślij potrawę  ",
                  width: 245,
                  height: 60,
                  icon: Icons.send_rounded,
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  onClicked: () => sendMeal(
                      context,
                      AddLoadImageScreen.pickedImage,
                      LabelMealScreen.inputText.text)),
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
