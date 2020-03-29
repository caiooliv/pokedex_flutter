import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/widgets/stat/stat.dart';

class PokemonStats extends StatelessWidget {
  const PokemonStats({Key key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Base Stats:",
              style: GoogleFonts.pressStart2P(
                fontSize: 20,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(children: [
                    Text(
                      'Height:',
                      style: GoogleFonts.pressStart2P(fontSize: 12),
                    ),
                    Text(
                      (pokemon.height / 10).toString()+" m",
                      style: GoogleFonts.pressStart2P(fontSize: 12),
                    ),
                  ]),
                  Row(children: [
                    Text(
                      'Weight:',
                      style: GoogleFonts.pressStart2P(fontSize: 12),
                    ),
                    Text(
                      (pokemon.weight/10).toString()+" kg",
                      style: GoogleFonts.pressStart2P(fontSize: 12),
                    ),
                  ]),
                ],
              ),
              SizedBox(height: 15,),
              Stat(type: 'HP', value: pokemon.stats[5]['base_stat'],pokemonType: pokemon.types[0]['type']['name'],),
              SizedBox(
                height: 10,
              ),
              Stat(type: 'Attack', value: pokemon.stats[4]['base_stat'],pokemonType: pokemon.types[0]['type']['name']),
              SizedBox(
                height: 10,
              ),
              Stat(type: 'Defense', value: pokemon.stats[3]['base_stat'],pokemonType: pokemon.types[0]['type']['name']),
              SizedBox(
                height: 10,
              ),
              Stat(type: 'Sp. Attack', value: pokemon.stats[2]['base_stat'],pokemonType: pokemon.types[0]['type']['name']),
              SizedBox(
                height: 10,
              ),
              Stat(type: 'Sp. Defense', value: pokemon.stats[1]['base_stat'],pokemonType: pokemon.types[0]['type']['name']),
              SizedBox(
                height: 10,
              ),
              Stat(type: 'Speed', value: pokemon.stats[0]['base_stat'],pokemonType: pokemon.types[0]['type']['name']),
            ],
          )
        ],
      ),
    );
  }
}
