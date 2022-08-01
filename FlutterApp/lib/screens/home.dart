import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/common/button.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFACC7E4),
      alignment: Alignment.center,
      child: ListView(
        padding:
            const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 13.0, top: 0),
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 60.0)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Center(
                  child: Text('Gourmet',
                      style: GoogleFonts.caveat(
                        fontSize: 90,
                        textStyle: const TextStyle(letterSpacing: 2),
                      )),
                ),
                Image.asset(
                  "assets/hot.png",
                  height: 245,
                ),
                Center(
                  child: Text('Jakub Sachajko & Łukasz Niedźwiadek © 2022',
                      style: GoogleFonts.caveat(
                        fontSize: 17,
                        textStyle: const TextStyle(letterSpacing: 0),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            // Login button
            child: generalButton(
              title: "Logowanie",
              icon: Icons.login_rounded,
              color: const Color(0xFFFE9901),
              textColor: Colors.white,
              onClicked: () => {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            // Registration button
            child: generalButton(
              title: "Rejestracja",
              textColor: Colors.white,
              icon: Icons.assignment_ind_rounded,
              color: const Color(0xFFFB2B3A),
              onClicked: () => {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            // About us Button
            child: generalButton(
              title: "O nas",
              icon: Icons.engineering_rounded,
              color: const Color(0xFF00AD2B),
              textColor: Colors.white,
              onClicked: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
