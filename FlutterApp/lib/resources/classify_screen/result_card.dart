library gourmet.result_card;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';

class CardDetails {
  String mealName;
  String mealDescription;
  double mealProbability;
  dynamic color;
  dynamic gradient1;
  dynamic gradient2;
  int numberOfStars;
  bool isExpanded;

  CardDetails({
    required this.mealName,
    required this.mealDescription,
    required this.mealProbability,
    required this.color,
    required this.gradient1,
    required this.gradient2,
    required this.numberOfStars,
    this.isExpanded = true,
  });
}

CardDetails cardDetails1 = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFE5B80B),
    gradient1: Colors.orange,
    gradient2: Colors.amber,
    numberOfStars: 3);

CardDetails cardDetails2 = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFC4CACE),
    gradient1: const Color(0xFF526573),
    gradient2: const Color(0xFF9CAABD),
    numberOfStars: 2);

CardDetails cardDetails3 = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFA46628),
    gradient1: const Color(0xFF7B4C1E),
    gradient2: const Color(0xFFB9772D),
    numberOfStars: 1);

List<CardDetails> resultCards = [cardDetails1, cardDetails2, cardDetails3];

Widget createCard(CardDetails cardDetails) {
  return Card(
    margin: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: cardDetails.numberOfStars == 3
              ? Wrap(children: <Widget>[
                  //Icon(Icons.star_rounded, color: Colors.amber),
                  //Icon(Icons.star_rounded, color: Colors.amber),
                  Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber,
                    size: 35,
                  ),
                ])
              : cardDetails.numberOfStars == 2
              ? Wrap(children: <Widget>[
                      //Icon(Icons.star_rounded),
                      //Icon(Icons.star_rounded),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.grey.shade300,
                        size: 35,
                      ),
                    ])
              : Wrap(children: <Widget>[
                      //Icon(Icons.star_rounded),
                      //Icon(Icons.star_border_rounded),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.brown,
                        size: 35,
                      ),
                    ]),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: ValueListenableBuilder<bool>(
            builder: (BuildContext context, bool value, Widget? child) {
              return value == true
                  ? mealName(text: cardDetails.mealName, isLoading: false)
                  : mealName(text: cardDetails.mealName, isLoading: true);
            },
            valueListenable: ResultScreen.isClassified,
            child: const SizedBox.shrink(),
          ),
          children: <Widget>[
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value == true
                    ? mealProbability(
                        probability: cardDetails.mealProbability,
                        isLoading: false)
                    : mealProbability(
                        probability: cardDetails.mealProbability,
                        isLoading: true);
              },
              valueListenable: ResultScreen.isClassified,
              child: const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value == true
                    ? mealDescription(
                        text: cardDetails.mealDescription, isLoading: false)
                    : mealDescription(
                        text: cardDetails.mealDescription, isLoading: true);
              },
              valueListenable: ResultScreen.isClassified,
              child: const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget mealName({required String text, required bool isLoading}) {
  return isLoading == false
      ? Text(
          text,
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24),
        )
      : const SpinKitThreeBounce(
          color: Colors.white,
          size: 40,
          duration: Duration(seconds: 2),
        );
}

Widget mealProbability({required double probability, required bool isLoading}) {
  return isLoading == false
      ? Text(
          "Prawdopodobieństwo: " + probability.toStringAsFixed(2) + "%",
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        )
      : const SizedBox();
}

Widget mealDescription({required String text, required bool isLoading}) {
  return isLoading == false
      ? Text(
          "Opis: " + text,
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        )
      : const SizedBox();
}
