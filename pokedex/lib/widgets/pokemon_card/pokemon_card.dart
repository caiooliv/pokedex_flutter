import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/pokemon_details/pokemon_details.dart';
import 'package:pokedex/extension/extensions.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key key, this.index, this.name}) : super(key: key);
  final index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PokemonDetails(
                    index: index,
                    name: name,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("#$index",
                        style: GoogleFonts.pressStart2P(fontSize: 15)),
                  ),
                  Text(name.capitalize(),
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
}
