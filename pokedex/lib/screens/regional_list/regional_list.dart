import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemon_card/pokemon_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class RegionalList extends StatefulWidget {
  final String region;
  RegionalList({Key key, @required this.region}) : super(key: key);

  @override
  _RegionalListState createState() => _RegionalListState(region);
}

class _RegionalListState extends State<RegionalList> {
  String region;
  RegionValues values;

  _RegionalListState(this.region);
  @override
  void initState() {
    super.initState();
    print(region);
    values = getValuesPerRegion(region);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPokemons(values.offset, values.limit),
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
                    index: index + values.index,
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
    );
  }

  Future<List> getPokemons(int offset, int limit) async {
    var offsetT = offset;
    var limitT = limit;
    var response = await http.get(
        "https://pokeapi.co/api/v2/pokemon?offset=${offsetT}&limit=${limitT}");

    final List pokemonList = [];
    var jsonResponse = jsonDecode(response.body);

    for (var pokemon in jsonResponse['results']) {
      pokemonList.add(pokemon);
    }

    return pokemonList;
  }

  RegionValues getValuesPerRegion(String region) {
    RegionValues values = new RegionValues();
    switch (region) {
      case ('kanto'):
        values.offset = 0;
        values.limit = 151;
        values.index = 1;
        print(values);
        return values;
      case ('johto'):
        values.offset = 151;
        values.limit = 100;
        values.index = 152;
        return values;
      case ('hoenn'):
        values.offset = 251;
        values.limit = 135;
        values.index = 252;
        return values;
      default:
        values.offset = 0;
        values.limit = 0;
        values.index = 0;
        return values;
    }
  }
}

class RegionValues {
  int offset;
  int limit;
  int index;
}
