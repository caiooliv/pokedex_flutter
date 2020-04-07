import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/regional_list/regional_list.dart';
import 'package:pokedex/widgets/pokemon_card/pokemon_card.dart';
import 'package:pokedex/screens/custom_search/custom_search.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            tabs: [
              Tab(
                text: "Kanto",
              ),
              Tab(
                text: "Johto",
              ),
              Tab(
                text: "Hoenn",
              ),
            ],
          ),
          centerTitle: true,
          title: Stack(
            children: <Widget>[
              Text(
                "Pokedex",
                style: TextStyle(
                  fontFamily: 'Pokemon',
                  fontSize: 35,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Color.fromARGB(255, 60, 90, 166),
                ),
              ),
              Text(
                "Pokedex",
                style: TextStyle(
                    fontFamily: 'Pokemon',
                    fontSize: 35,
                    color: Color.fromARGB(255, 247, 202, 19)),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearch());
                }),
          ],
        ),
        body: TabBarView(children: [
          RegionalList(region: 'kanto'),
          RegionalList(region: 'johto'),
          RegionalList(region: 'hoenn'),
        ]),
      ),
    );
  }
}
