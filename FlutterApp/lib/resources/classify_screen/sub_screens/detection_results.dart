import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../common/load_image_dialog.dart';
import '../../common/methods.dart';
import 'classify_results.dart';

class DetectionResultScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? detectedImage;
  static ValueNotifier<bool> isClassified = ValueNotifier<bool>(false);

  const DetectionResultScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DetectionResultScreen> createState() => _DetectionResultScreen();
}

class _DetectionResultScreen extends State<DetectionResultScreen> {
  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("results rebuild!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.fastfood_rounded, size: 29),
        title: const Text('Wyniki detekcji', style: TextStyle(fontSize: 22)),
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
              onPressed: () => navigateToCatalog(context),
              backgroundColor: Colors.deepPurpleAccent,
              splashColor: Colors.deepPurpleAccent,
              label: const Text('Katalog'),
              icon: const Icon(Icons.format_list_bulleted_rounded),
            ),
          ],
        ),
      ),
      body: ShowUpAnimation(
        animationDuration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCirc,
        direction: Direction.vertical,
        offset: 0.5,
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, bottom: 13.0, top: 50),
            children: [
              const SizedBox(
                height: 50,
              ),
              ValueListenableBuilder<bool>(
                builder: (BuildContext context, bool value, Widget? child) {
                  return value == true
                      ? imageBox(isDetected: true)
                      : imageBox(isDetected: false);
                },
                valueListenable: ResultScreen.isClassified,
                child: const SizedBox.shrink(),
              ),
              const SizedBox(
                height: 125,
              ),
            ]),
      ),
    );
  }

  Widget imageBox({required bool isDetected}) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
              boxShadow: [
                isDetected == true
                    ? const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(0.0, 0.0), // shadow direction: bottom right
                      )
                    : const BoxShadow(color: Colors.transparent)
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: isDetected == true
                    ? Image.memory(
                        DetectionResultScreen.detectedImage!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.scaleDown,
                      )
                    : Image.asset(
                        'assets/diet.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      )),
          ),
        ),
        Center(
          child: LoadImageDialog(
            onClick: callSetState,
            imageSource1: ImageSource.gallery,
            imageSource2: ImageSource.camera,
            iconData1: Icons.photo_library_rounded,
            iconData2: Icons.camera_alt_rounded,
            text1: " Wybierz zdjęcie",
            text2: "     Zrób zdjęcie  ",
            menuOffset: const Offset(42, 175),
            menuWidth: 300,
            menuOpacity: 0.0,
            menuHeight: 300,
            isButton: false,
            forClassification: true,
          ),
        ),
        const SizedBox(
          height: 220,
        ),
      ],
    );
  }
}
