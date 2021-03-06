import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget classifyPageIndicator({
  required PageController controller,
  required int count,
}) =>
    Center(
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
