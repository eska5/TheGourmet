import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/load_image.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';

import '../resources/common/page_indicator.dart';

class ClassifyImage extends StatefulWidget {
  const ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _AddImageState();
}

class _AddImageState extends State<ClassifyImage> {
  // String domain = getDomain(1); //0 IS FOR DEVELOPMENT, 1 IS FOR PRODUCTION
  //
  // TextEditingController inputText = TextEditingController();
  // TextEditingController recognizedMeal =
  //     TextEditingController(text: "Tutaj pojawi się wynik");
  //
  // // Response popUp variables
  // String responseTitle = "";
  // String responseText1 = "";
  // String responseText2 = "";
  // String responseText3 = "";v
  // String responseColor = "";

  final PageController controller = PageController();

  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("classify rebuild!");
        //print(LoadImageScreen.pickedImage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        classifyPageIndicator(controller: controller, count: 2),
        Flexible(
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: [
              LoadImageScreen(
                controller: controller,
              ),
              ResultScreen(
                controller: controller,
              ),
            ],
          ),
        ),
        Positioned(
            right: MediaQuery.of(context).size.width / 2 - 24,
            top: MediaQuery.of(context).padding.top + 66,
            child: classifyPageIndicator(controller: controller, count: 2)),
      ],
    );
  }
}
