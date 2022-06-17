import 'package:flutter/material.dart';
import 'package:new_ui/components/globals.dart';
import 'package:new_ui/components/tile.dart';

Widget createCard(Tile tile) {return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [tile.gradient1, tile.gradient2],
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
                  leading: tile.numberOfStars == 3 ?
                  Wrap(children: <Widget>[
                    Icon(Icons.star_rounded),
                    Icon(Icons.star_rounded),
                    Icon(Icons.star_rounded),
                  ]): tile.numberOfStars == 2 ?
                  Wrap(children: <Widget>[
                    Icon(Icons.star_rounded),
                    Icon(Icons.star_rounded),
                    Icon(Icons.star_border_rounded ),
                  ]):
                  Wrap(children: <Widget>[
                    Icon(Icons.star_rounded),
                    Icon(Icons.star_border_rounded ),
                    Icon(Icons.star_border_rounded ),
                  ])
                  ,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  title: Text(tile.mealName, style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),),
                  children: <Widget>[
                    Text("Prawdopodobieństwo: " + tile.mealProbability.toStringAsFixed(2) + "%",
                    style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Opis: " + tile.mealDescription, style: TextStyle(
                      fontFamily: 'avenir',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
          }