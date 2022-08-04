import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/common/button.dart';
import '../resources/common/my_flutter_app_icons.dart';
import '../resources/home_screen/home_methods.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gourmet AI',
                      style: GoogleFonts.ubuntu(
                        fontSize: 60,
                        textStyle: const TextStyle(
                            letterSpacing: 2, fontWeight: FontWeight.w400),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                "assets/hot.png",
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFACC7E4),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        'Pozwól sztucznej inteligencji rozpoznać co masz na talerzu',
                        style: GoogleFonts.ubuntu(
                          fontSize: 23,
                          textStyle: const TextStyle(letterSpacing: 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: generalButton(
                      title: "Rozpocznij",
                      color: const Color(0xFFFE9901),
                      textColor: Colors.white,
                      onClicked: () => handleButtonClick(),
                      icon: MyFlutterApp.brain,
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   child: GButton(
                  //     onPressed: () {
                  //       MyApp.controller.animateToPage(0,
                  //           duration: const Duration(milliseconds: 500),
                  //           curve: Curves.ease);
                  //     },
                  //     gap: 10,
                  //     icon: Icons.home,
                  //     iconColor: Colors.white,
                  //     iconActiveColor: Colors.white,
                  //     text: 'Home',
                  //     textColor: Colors.white,
                  //     backgroundColor: Colors.white.withOpacity(0.2),
                  //     iconSize: 25,
                  //     padding: const EdgeInsets.fromLTRB(25, 24, 25, 24),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
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
            )
          ],
        ),
      ),
    );
  }
}
