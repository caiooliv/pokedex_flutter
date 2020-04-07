import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      appBar: AppBar(
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
      body: FutureBuilder(
        future: getPokemons(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.none):
            case (ConnectionState.waiting):
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/poke.gif'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Capturando pokemons !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.pressStart2P(
                            fontSize: 20,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            default:
              if (snapshot.hasData) {
                List pokemonList = snapshot.data;
                return ListView.builder(
                  itemCount: pokemonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PokemonCard(
                      index: index + 1,
                      name: pokemonList[index]['name'],
                    );
                  },
                );
              } else {
                return Container(
                  child: Text("Sem pokemon"),
                );
              }
          }
        },
      ),
    );
  }

  Future<List> getPokemons() async {
    var response =
        await http.get("https://pokeapi.co/api/v2/pokemon?offset=0&limit=151");

    final List pokemonList = [];
    var jsonResponse = jsonDecode(response.body);

    for (var pokemon in jsonResponse['results']) {
      pokemonList.add(pokemon);
    }

    return pokemonList;
  }
}
