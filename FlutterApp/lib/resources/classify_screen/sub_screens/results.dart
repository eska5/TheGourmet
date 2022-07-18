import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/common/page_indicator.dart';

import '../../common/button.dart';
import '../../common/load_image_dialog.dart';
import '../methods.dart';
import '../result_card.dart';
import 'load_image.dart';

class ResultScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? pickedImage;

  //static bool isClassified = false;
  static ValueNotifier<bool> isClassified = ValueNotifier<bool>(true);

  //final Function onClick;

  const ResultScreen({
    Key? key,
    required this.controller,
    //required this.onClick,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreen();
}

class _ResultScreen extends State<ResultScreen> {
  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("results rebuild!");
        //widget.onClick();
        //print(LoadImageScreen.pickedImage);
      }
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
            Stack(
              children: <Widget>[
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: LoadImageScreen.pickedImage != null
                          ? Image.memory(
                              LoadImageScreen.pickedImage!,
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
                Positioned(
                  right: 65,
                  top: -15,
                  child: LoadImageDialog(
                    onClick: callSetState,
                    imageSource1: ImageSource.gallery,
                    imageSource2: ImageSource.camera,
                    iconData1: Icons.photo_library_rounded,
                    iconData2: Icons.camera_alt_rounded,
                    text1: " Wybierz zdjęcie",
                    text2: "     Zrób zdjęcie  ",
                    menuOffset: const Offset(19, 216),
                    menuWidth: 230,
                    menuOpacity: 0.0,
                    menuHeight: 230,
                  ),
                ),
                const SizedBox(
                  height: 220,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SingleChildScrollView(
              child: Column(
                children: [for (var card in resultCards) createCard(card)],
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
