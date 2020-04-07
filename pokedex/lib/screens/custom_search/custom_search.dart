import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokemon_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokedex/widgets/last_seen_card/last_seen_card.dart';
import 'package:pokedex/widgets/pokemon_card/pokemon_card.dart';

class CustomSearch extends SearchDelegate {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.redAccent,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
    );
  }

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => "Índex ou nome";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getPokemon(query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.none):
          case (ConnectionState.waiting):
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 200,
                    ),
                    Text(
                      "Procure por index ou nome !",
                      style: GoogleFonts.pressStart2P(fontSize: 12),
                    )
                  ],
                ),
              );
            } else {
              Pokemon pokemon = Pokemon.fromJson(snapshot.data);
              return PokemonCard(
                index: pokemon.id,
              );
            }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Pesquisas recentes :",
                  style: GoogleFonts.pressStart2P(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: _getFavorites(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List lista = snapshot.data;

                      return ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          return LastSeenCard(
                            index: lista[index],
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: getPokemon(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.none):
            case (ConnectionState.waiting):
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_dissatisfied,
                        size: 150,
                      ),
                      Text(
                        "Pokemon não encontrado",
                        style: GoogleFonts.pressStart2P(fontSize: 12),
                      )
                    ],
                  ),
                );
              } else {
                Pokemon pokemon = Pokemon.fromJson(snapshot.data);
                return PokemonCard(
                  index: pokemon.id,
                );
              }
          }
        },
      );
    }
  }

  Future getPokemon(String index) async {
    var response = await http.get("https://pokeapi.co/api/v2/pokemon/$index/");

    var jsonReponse = jsonDecode(response.body);

    return jsonReponse;
  }

  Future<List> _getFavorites() async {
    final SharedPreferences prefs = await _prefs;
    final lastSeen = prefs.getStringList('lastSeen');
    return lastSeen;
  }
}
