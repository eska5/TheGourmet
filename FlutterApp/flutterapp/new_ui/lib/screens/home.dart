import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:new_ui/components/button.dart';
import 'package:new_ui/functions/func.dart';

import 'package:new_ui/popupcard/add_todo_button.dart';
import 'package:new_ui/popupcard/custom_rect_tween.dart';
import 'package:new_ui/popupcard/hero_dialog_route.dart';



import 'package:flutter/material.dart';

    final GlobalKey<State> _LoaderDialog = GlobalKey<State>();

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    //var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          child: Dialog(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(70))),
              key: key,
              backgroundColor: Color.fromARGB(255, 240, 145, 44),
              child:  new Container(
              child: new SingleChildScrollView(
              child: new Column(
        children: [ 
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0), //apply padding to all four sides
                child: Text("O projekcie",style: GoogleFonts.comfortaa(
                fontSize: 32,
                textStyle: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold ),
              )),
              ),
               Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0), //apply padding to all four sides
                child: Text(
                  "Celem aplikacji jest zbieranie podpisanych zdjęć żywności, które potem użyjemy do uczenia modelu sieci neuronowej, której zadaniem będzie rozpoznawanie jedzenia na podstwie zdjęć. Dziękujemy za wkład i poświęcony czas.",style: GoogleFonts.comfortaa(
                fontSize: 18,
                textStyle: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold ),
              )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0), //apply padding to all four sides
                child: Text("Instrukcja",style: GoogleFonts.comfortaa(
                fontSize: 32,
                textStyle: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold ),
              )),
              ),
               Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10), //apply padding to all four sides
                child: Text(
                  "Po wybraniu \"Dodaj potrawę\" w menu,. Następnie podpisz zdjęcie używając pola do wprowadzania tekstu. Jeśli nazwa potrawy, którą chcesz wprowadzić znajduję się w panelu sugestii, skorzystaj z podpowiedzi.",
                  style: GoogleFonts.comfortaa(
                fontSize: 18,
                textStyle: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold ),
              )),
              ),
               Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20), //apply padding to all four sides
                  child: InfoButton(
                  title: "1234",
                  icon: Icons.info_outline_rounded, 
                  onClicked: () =>  Navigator.pop(context, _LoaderDialog.currentContext))
               ),
                  ]
               
          ),
              ),
              ),
          ),
        );
      },
    );
  }
}

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
            height: smallSreen() ? 5 : 30,
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
          
          // InfoButton(
          //   title: 'Instrukcja',
          //   icon: Icons.info_outline_rounded,
          //   onClicked: () => LoaderDialog.showLoadingDialog(context, _LoaderDialog),
          // ),
          // SizedBox(
          //   height: 25,
          // ),
          const Align(
            alignment: Alignment.bottomCenter,
            child:  AddTodoButton(),
          )
          
        ],
      ),
    );
  }
}

/// {@template todo_popup_card}
/// Popup card to expand the content of a [Todo] card.
///
/// Activated from [_TodoCard].
/// {@endtemplate}
class _TodoPopupCard extends StatelessWidget {
  const _TodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "ID",
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.amberAccent,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        maxLines: 8,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Write a note...',
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


