import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ui/resources/add_screen/sub_screens/label_meal.dart';
import 'package:new_ui/resources/add_screen/sub_screens/load_image.dart';
import 'package:new_ui/resources/add_screen/sub_screens/summary.dart';

import '../resources/common/page_indicator.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImage();
}

class _AddImage extends State<AddImage> {
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
            AddLoadImageScreen(
              controller: controller,
            ),
            LabelMealScreen(controller: controller),
            SummaryScreen(controller: controller),
          ],
        ),
        pageIndicator(controller: controller, count: 3, context: context),
      ],
    );
  }
}
