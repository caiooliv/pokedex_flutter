import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/widgets/pokemon_stats/pokemon_stats.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/widgets/types_chips/types_chips.dart';
import 'package:pokedex/extension/extensions.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({Key key, this.index, this.name}) : super(key: key);
  final index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name.capitalize(),
          style: GoogleFonts.pressStart2P(),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(
        future: getPokemon(index.toString()),
        builder: (contex, snapshot) {
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
                        image: AssetImage('assets/pokeball-gif.gif'),
                        width: 180,
                        height: 180,
                      ),
                      Text(
                        "Capturando pokemon !",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pressStart2P(
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            default:
              if (snapshot.hasData) {
                Pokemon pokemon = snapshot.data;
                return Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$index.png",
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Types:",
                              style: GoogleFonts.pressStart2P(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          TypesChip(
                            types: pokemon.types,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: PokemonStats(pokemon: pokemon),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      height: 500,
                      width: 500,
                      left: 100,
                      child: Opacity(
                        opacity: 0.03,
                        child: Image.network(
                          "https://raw.githubusercontent.com/scitbiz/flutter_pokedex/master/assets/images/pokeball.png",
                        ),
                      ),
                    )
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Future<Pokemon> getPokemon(String index) async {
    var response = await http.get("https://pokeapi.co/api/v2/pokemon/$index");
    var responseJson = jsonDecode(response.body);
    Pokemon pokemon = Pokemon.fromJson(responseJson);
    print(pokemon.types[0]);
    return pokemon;
  }
}
