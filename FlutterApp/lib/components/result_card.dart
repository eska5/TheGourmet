library gourmet.result_card;

import 'package:flutter/material.dart';

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
    mealName: "[Animacja 3 kropek]",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFE5B80B),
    gradient1: Colors.orange,
    gradient2: Colors.amber,
    numberOfStars: 3);

CardDetails cardDetails2 = CardDetails(
    mealName: "[Animacja 3 kropek]",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFC4CACE),
    gradient1: const Color(0xFF526573),
    gradient2: const Color(0xFF9CAABD),
    numberOfStars: 2);

CardDetails cardDetails3 = CardDetails(
    mealName: "[Animacja 3 kropek]",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFA46628),
    gradient1: const Color(0xFF7B4C1E),
    gradient2: const Color(0xFFB9772D),
    numberOfStars: 1);

List<CardDetails> resultCards = [cardDetails1, cardDetails2, cardDetails3];

Widget createCard(CardDetails cardDetails) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardDetails.gradient1, cardDetails.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: cardDetails.numberOfStars == 3
              ? Wrap(children: <Widget>[
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_rounded),
                  Icon(Icons.star_rounded),
                ])
              : cardDetails.numberOfStars == 2
                  ? Wrap(children: <Widget>[
                      Icon(Icons.star_rounded),
                      Icon(Icons.star_rounded),
                      Icon(Icons.star_border_rounded),
                    ])
                  : Wrap(children: <Widget>[
                      Icon(Icons.star_rounded),
                      Icon(Icons.star_border_rounded),
                      Icon(Icons.star_border_rounded),
                    ]),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text(
            cardDetails.mealName,
            style: TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24),
          ),
          children: <Widget>[
            Text(
              "Prawdopodobieństwo: " +
                  cardDetails.mealProbability.toStringAsFixed(2) +
                  "%",
              style: TextStyle(
                  fontFamily: 'avenir',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Opis: " + cardDetails.mealDescription,
              style: TextStyle(
                  fontFamily: 'avenir',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
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
