import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/resources/common/button.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../add_methods.dart';

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
        print("load_image rebuild!");
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
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),
              backgroundColor: Colors.green,
              splashColor: Colors.green,
              label: const Text('Wróć'),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => widget.controller.animateToPage(1,
                  duration: Duration(milliseconds: 800),
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
            Center(
              // Send the meal button
              child: generalButton(
                  title: "Wyślij potrawę  ",
                  icon: Icons.send_rounded,
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  onClicked: () => sendToServer()),
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
