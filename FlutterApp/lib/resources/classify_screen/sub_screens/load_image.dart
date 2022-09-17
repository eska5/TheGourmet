import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/common/load_image_dialog.dart';
import 'package:new_ui/screens/classify.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../common/methods.dart';

class ClassifyLoadImageScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? pickedClassificationImage;
  static Uint8List? pickedDetectionImage;
  final Function onClick;
  static ValueNotifier<bool> isDetectionSet = ValueNotifier<bool>(false);

  const ClassifyLoadImageScreen({
    Key? key,
    required this.controller,
    required this.onClick,
  }) : super(key: key);

  @override
  State<ClassifyLoadImageScreen> createState() => _LoadImageScreen();
}

class _LoadImageScreen extends State<ClassifyLoadImageScreen> {
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
        title:
            const Text('Co masz na talerzu?', style: TextStyle(fontSize: 22)),
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
              onPressed: () => navigateToCatalog(context),
              backgroundColor: Colors.deepPurpleAccent,
              splashColor: Colors.deepPurpleAccent,
              label: const Text('Katalog'),
              icon: const Icon(Icons.format_list_bulleted_rounded),
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
            Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent,
                      boxShadow: [
                        ClassifyLoadImageScreen.pickedClassificationImage !=
                                null
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
                        child:
                            ClassifyLoadImageScreen.pickedClassificationImage !=
                                    null
                                ? Image.memory(
                                    ClassifyLoadImageScreen
                                        .pickedClassificationImage!,
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
                      menuWidth: 200,
                      menuOpacity: 0.0,
                      menuHeight: 200,
                      isButton: false,
                      forClassification: true),
                ),
                const SizedBox(
                  height: 220,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(0.0, 0.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: ToggleSwitch(
                  minWidth: 147.0,
                  initialLabelIndex: ClassifyImage.isClassificationSet ? 1 : 0,
                  cornerRadius: 10.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: const ['Detekcja', 'Klasyfikacja'],
                  iconSize: 26,
                  customTextStyles: const [
                    TextStyle(fontSize: 17, color: Colors.white)
                  ],
                  icons: const [
                    Icons.location_searching_rounded,
                    Icons.category_rounded,
                  ],
                  activeBgColors: [
                    const [Colors.deepPurpleAccent],
                    [Colors.blue.shade400],
                  ],
                  onToggle: (index) {
                    if (index == 1) {
                      ClassifyImage.isClassificationSet = true;
                    } else {
                      ClassifyImage.isClassificationSet = false;
                    }
                    print(
                        "isClassificationSet: ${ClassifyImage.isClassificationSet}");
                    widget.onClick();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
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
                menuOffset: const Offset(15, -10),
                menuWidth: 245,
                menuOpacity: 1.0,
                menuHeight: 60,
                isButton: true,
                forClassification: true,
                menuInnerWidget: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_photo_alternate_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Załaduj zdjęcie",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
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
