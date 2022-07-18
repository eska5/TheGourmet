import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/screens/add.dart';
import 'package:new_ui/screens/classify.dart';
import 'package:new_ui/screens/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Widget navBar({
  required PageController controller,
  int selectedIndex = 0,
  var padding = const EdgeInsets.fromLTRB(5, 18, 5, 18),
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
          return widgetOptions[selectedIndex];
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
        decoration: const BoxDecoration(
          color: Colors.indigo,
        ),
        child: GNav(
          rippleColor:
              Colors.grey[800]!, // tab button ripple color when pressed
          hoverColor: Colors.grey[700]!, // tab button hover color
          haptic: true, // haptic feedback
          curve: Curves.bounceIn, // tab animation curves
          duration: const Duration(milliseconds: 800), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              Colors.white.withOpacity(0.1), // selected tab background color
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
              iconSize: 24,
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
      )),
    );
