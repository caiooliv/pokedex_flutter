import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/pokemon_details/pokemon_details.dart';
import 'package:pokedex/extension/extensions.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LastSeenCard extends StatelessWidget {
  const LastSeenCard({
    Key key,
    this.index,
  }) : super(key: key);
  final index;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPokemon(index),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.none):
            case (ConnectionState.waiting):
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                ),
              );
            default:
              Pokemon pokemon = Pokemon.fromJson(snapshot.data);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokemonDetails(
                              index: index,
                              name: pokemon.name,
                            )),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    height: 120,
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index}.png"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("#$index",
                                  style:
                                      GoogleFonts.pressStart2P(fontSize: 15)),
                            ),
                            Text(pokemon.name.capitalize(),
                                style: GoogleFonts.pressStart2P(fontSize: 15)),
                          ],
                        ),
                        Positioned(
                          width: 150,
                          height: 150,
                          left: 250,
                          child: Opacity(
                            opacity: 0.1,
                            child: Image.network(
                              "https://raw.githubusercontent.com/scitbiz/flutter_pokedex/master/assets/images/pokeball.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        });
  }

  Future getPokemon(String index) async {
    var response = await http.get("https://pokeapi.co/api/v2/pokemon/$index/");

    var jsonReponse = jsonDecode(response.body);

    return jsonReponse;
  }
}
