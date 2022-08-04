import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_ui/screens/add.dart';
import 'package:new_ui/screens/classify.dart';
import 'package:new_ui/screens/home.dart';

Widget navBar({
  required PageController controller,
  required int selectedIndex,
  var padding = const EdgeInsets.fromLTRB(25, 24, 25, 24),
  double gap = 10,
  List<Widget> widgetOptions = const <Widget>[
    Home(),
    ClassifyImage(),
    AddImage(),
  ],
}) =>
    Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        controller: controller,
        itemBuilder: (context, option) {
          selectedIndex = option;
          print(selectedIndex);
          return widgetOptions[selectedIndex];
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.indigo,
        ),
        child: GNav(
          rippleColor: Colors.grey[800]!,
          hoverColor: Colors.grey[700]!,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
          gap: 8,
          color: Colors.grey[800],
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white.withOpacity(0.1),
          // selected tab background color
          tabs: [
            GButton(
              onPressed: () {
                controller.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              gap: gap,
              icon: Icons.home,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: 'Home',
              textColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(0.2),
              iconSize: 25,
              padding: padding,
            ),
            GButton(
              onPressed: () {
                controller.animateToPage(1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              gap: gap,
              icon: Icons.calculate_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: 'Rozpoznaj',
              textColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(0.2),
              iconSize: 24,
              padding: padding,
            ),
            GButton(
              onPressed: () {
                controller.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              gap: gap,
              icon: Icons.add_photo_alternate_rounded,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              text: 'Dodaj nową',
              textColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(0.2),
              iconSize: 24,
              padding: padding,
            ),
          ],
        ),
      ),
    );
