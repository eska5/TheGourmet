import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_ui/resources/common/load_image_dialog.dart';

import '../../common/button.dart';
import '../methods.dart';

class LoadImageScreen extends StatefulWidget {
  final PageController controller;
  static Uint8List? pickedImage;

  //final Function onClick;

  const LoadImageScreen({
    Key? key,
    required this.controller,
    //required this.onClick,
  }) : super(key: key);

  @override
  State<LoadImageScreen> createState() => _LoadImageScreen();
}

class _LoadImageScreen extends State<LoadImageScreen> {
  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("load_image rebuild!");
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
        leading: const Icon(Icons.add_box_rounded, size: 29),
        title:
            const Text('Co masz na talerzu?', style: TextStyle(fontSize: 22)),
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
        padding: const EdgeInsets.only(
            left: 13.0, right: 13.0, bottom: 13.0, top: 45),
        children: [
          const SizedBox(
            height: 30,
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
              Center(
                child: LoadImageDialog(
                  onClick: callSetState,
                  imageSource1: ImageSource.gallery,
                  imageSource2: ImageSource.camera,
                  iconData1: Icons.photo_library_rounded,
                  iconData2: Icons.camera_alt_rounded,
                  text1: " Wybierz zdj??cie",
                  text2: "     Zr??b zdj??cie  ",
                  menuOffset: const Offset(42, 175),
                  menuWidth: 200,
                  menuOpacity: 0.0,
                  menuHeight: 200,
                ),
              ),
              const SizedBox(
                height: 220,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: enabledButton(
              title: 'Dalej    ',
              icon: Icons.arrow_forward_rounded,
              onClicked: () => widget.controller.animateToPage(1,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeOutQuint),
              backgroundColor: Colors.blue.shade400,
              fontSize: 20,
              enabled: true,
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
              text1: " Wybierz zdj??cie",
              text2: "     Zr??b zdj??cie  ",
              menuOffset: const Offset(15, -10),
              menuWidth: 245,
              menuOpacity: 1.0,
              menuHeight: 60,
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
                    "Za??aduj zdj??cie",
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
    );
  }
}
