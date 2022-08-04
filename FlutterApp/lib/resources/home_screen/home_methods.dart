import 'package:flutter/material.dart';

import '../../main.dart';

void handleButtonClick() {
  MyApp.selectedIndex = 1;
  MyApp.controller.animateToPage(1,
      duration: const Duration(milliseconds: 800), curve: Curves.easeOutQuint);
}
