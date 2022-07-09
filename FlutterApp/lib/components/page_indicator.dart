import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget classifyPageIndicator({
  required PageController controller,
}) =>
    Center(
      child: SmoothPageIndicator(
        controller: controller, // PageController
        count: 2,
        effect: const SlideEffect(
            spacing: 8.0,
            radius: 45.0,
            dotWidth: 20.0,
            dotHeight: 16.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 1.5,
            dotColor: Colors.blue,
            activeDotColor: Colors.blue), // your preferred effect
      ),
    );
