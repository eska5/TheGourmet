import 'package:flutter/material.dart';
import 'package:new_ui/components/globals.dart';
import 'package:new_ui/popupcard/custom_rect_tween.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/components/button.dart';
import 'package:universal_platform/universal_platform.dart';


import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard2].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButton2 extends StatelessWidget {
  /// {@macro add_todo_button}
  dynamic mobileImageCliassify;
  dynamic modelOutput;
  dynamic chance;
  dynamic data;
  dynamic chosenColor;
  AddTodoButton2({Key? key,required this.mobileImageCliassify,required this.modelOutput,required this.chance,required this.data, required this.chosenColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12,top: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _AddTodoPopupCard2(key:key, modelOutput: modelOutput,chance: chance,data: data, mobileImageCliassify: mobileImageCliassify, chosenColor: chosenColor);
          }));
        },
        child: Hero(
          tag: modelOutput,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
              color: chosenColor,
              shadowColor: Colors.blue,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SizedBox(
                  width: 190, // <-- Your width
                  height: 55, // <-- Your height
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //TUTAJ IKONKA JAK TRZEBA
                      //Icon(Icons.info_outline_rounded,
                      //    size: 28, color: Colors.white),
                      Text(
                        modelOutput,
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
String _heroAddTodo = modelOutput;

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _AddTodoPopupCard2 extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  dynamic mobileImageCliassify;
  dynamic modelOutput;
  dynamic chance;
  dynamic data;
  Color chosenColor;
  _AddTodoPopupCard2({Key? key,required this.mobileImageCliassify,required this.modelOutput,required this.chance,required this.data, required this.chosenColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 80, bottom: 100),
        child: Hero(
          tag: modelOutput,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: chosenColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 16, bottom: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                          bottom: 20), //apply padding to all four sides
                      child: Text(modelOutput,
                          style: GoogleFonts.comfortaa(
                            fontSize: 32,
                            textStyle: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 20), //apply padding to all four sides
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: UniversalPlatform.isWeb
                        ? Image.memory(
                            mobileImageCliassify,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            mobileImageCliassify,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 20), //apply padding to all four sides
                      child: Text( "Pewnosc: " + (chance*100).toStringAsFixed(2) + "%.",
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                            textStyle: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 20), //apply padding to all four sides
                      child: Text(
                          data,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            textStyle: TextStyle(
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(
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
                            children: [
                              Icon(Icons.exit_to_app_outlined, size: 28),
                              const SizedBox(width: 10),
                              Text("Powrót"),
                            ],
                          ),
                          onPressed: () =>
                              Navigator.pop(context, _AddTodoPopupCard2(key:key,mobileImageCliassify: mobileImageCliassify,modelOutput: modelOutput,chance: chance,data: data, chosenColor: chosenColor,)),
                        ),
                      ),
                    )
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
