import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/button.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFACC7E4),
      alignment: Alignment.center,
      child: ListView(
        padding:
            const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 13.0, top: 0),
        children: [
          Container(
            //margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
            //padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
            height: 400,
            decoration: new BoxDecoration(
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
            child: NavigationButton(
              title: "Logowanie",
              icon: Icons.login_rounded,
              onClicked: () => {},
              backgroundColor: Color(0xFFFE9901),
              fontSize: 20,
              enabled: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: NavigationButton(
              title: "Rejestracja",
              icon: Icons.assignment_ind_rounded,
              onClicked: () => {},
              backgroundColor: Color(0xFFFB2B3A),
              fontSize: 20,
              enabled: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: NavigationButton(
              title: "O nas",
              icon: Icons.engineering_rounded,
              onClicked: () => {},
              backgroundColor: Color(0xFF00AD2B),
              fontSize: 20,
              enabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
