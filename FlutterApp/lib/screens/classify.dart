import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/load_image.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';

import '../resources/common/page_indicator.dart';

class ClassifyImage extends StatefulWidget {
  const ClassifyImage({Key? key}) : super(key: key);

  @override
  State<ClassifyImage> createState() => _ClassifyImage();
}

class _ClassifyImage extends State<ClassifyImage> {
  final PageController controller = PageController();

  void callSetState() {
    setState(() {
      if (kDebugMode) {
        print("classify rebuild!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView(
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
        classifyPageIndicator(
            controller: controller, count: 2, context: context),
      ],
    );
  }
}
