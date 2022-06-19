import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String responseTitle = "";
String responseText1 = "";
String responseText2 = "";
String responseText3 = "";
String responseColor = "";

final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

class ClassifyLoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(70))),
              key: key,
              backgroundColor: Colors.indigo[50],
              child: Container(
                width: 150.0,
                height: 250.0,
                child: Image.asset(
                  'assets/plate.gif',
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
              )),
        );
      },
    );
  }
}

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context,
      GlobalKey key,
      String responseTitle,
      String responseText1,
      String responseText2,
      String responseText3,
      String responseColor) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 32, right: 32, top: 80, bottom: 100),
            child: Material(
              color: Colors.indigo,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 16, bottom: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 20,
                            bottom: 20), //apply padding to all four sides
                        child: Text(responseTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                              fontSize: 32,
                              textStyle: const TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 10,
                            bottom: 20), //apply padding to all four sides
                        child: RichText(
                          text: TextSpan(
                            text: responseText1,
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              textStyle: const TextStyle(
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: responseText2,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  textStyle: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: responseColor == "Colors.green"
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                              TextSpan(
                                text: responseText3,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 15,
                            bottom: 15), //apply padding to all four sides
                        child: SizedBox(
                          width: 235, // <-- Your width
                          height: 60, // <-- Your height
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.indigo,

                              textStyle: TextStyle(fontSize: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              //minimumSize: const Size(40, 60),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.exit_to_app_outlined, size: 28),
                                SizedBox(width: 10),
                                Text("Powrót"),
                              ],
                            ),
                            onPressed: () => Navigator.pop(
                                context, _LoaderDialog.currentContext),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
