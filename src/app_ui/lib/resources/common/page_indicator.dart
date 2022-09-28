import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget pageIndicator({
  required PageController controller,
  required int count,
  required BuildContext context,
}) =>
    Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 66),
      child: SmoothPageIndicator(
        controller: controller, // PageController
        count: count,
        effect: const WormEffect(
          dotHeight: 22,
          dotWidth: 24,
          spacing: 20,
          activeDotColor: Color(0xFF5C6BC0),
        ),
      ),
    );
