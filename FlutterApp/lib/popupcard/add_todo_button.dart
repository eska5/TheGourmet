import 'package:flutter/material.dart';
import 'package:new_ui/popupcard/custom_rect_tween.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/components/button.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 32),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const _AddTodoPopupCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
              color: Colors.indigo,
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
                      const Icon(Icons.info_outline_rounded,
                          size: 28, color: Colors.white),
                      const Text(
                        " Instrukcja",
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
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 80, bottom: 100),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.indigo,
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
                      child: Text("O projekcie",
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
                      child: Text(
                          "Celem aplikacji jest zbieranie podpisanych zdjęć żywności, które potem użyjemy do uczenia modelu sieci neuronowej, której zadaniem będzie rozpoznawanie jedzenia na podstwie zdjęć. Dziękujemy za wkład i poświęcony czas.",
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
                          top: 10,
                          bottom: 20), //apply padding to all four sides
                      child: Text("Instrukcja",
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
                      child: Text(
                          "W podstronie \"Dodaj potrawę\", znajduję się przycisk \"Wybierz zdjęcie\", użyj go aby wybrać zdjęcie z galerii albo zrobić je aparatem. Następnie podpisz zdjęcie używając pola do wprowadzania tekstu. Jeśli nazwa potrawy, którą chcesz wprowadzić znajduję się w panelu sugestii, skorzystaj z podpowiedzi. Po wprowadzeniu nazwy i obrazka, kliknij przycisk wyślij.",
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
                              Navigator.pop(context, _AddTodoPopupCard()),
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
