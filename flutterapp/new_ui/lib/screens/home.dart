import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:new_ui/components/button.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[50],
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          Text('Gourmet',
              style: GoogleFonts.caveat(
                fontSize: 90,
                textStyle: TextStyle(letterSpacing: 7),
              )),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/hot.png",
            height: 290,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Jakub Sachajko & Łukasz Niedźwiadek © 2022',
              style: GoogleFonts.caveat(
                fontSize: 17,
                textStyle: TextStyle(letterSpacing: 0),
              )),
          Expanded(child: Container()),
          InfoButton(
            title: 'Instrukcja',
            icon: Icons.info_outline_rounded,
            onClicked: () => displayInfo(),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

void displayInfo() {}
