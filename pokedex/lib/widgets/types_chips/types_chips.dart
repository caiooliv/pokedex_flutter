import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:pokedex/extension/extensions.dart";

class TypesChip extends StatelessWidget {
  const TypesChip({Key key, this.types}) : super(key: key);
  final List types;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: 30,
          children: <Widget>[
            for (var type in types)
              Chip(
                elevation: 3,
                label: Text(
                  type['type']['name'],
                  style: GoogleFonts.pressStart2P(
                    fontSize: 15,
                    color: Colors.white
                  ),
                ),
                backgroundColor: getColorByType(type['type']['name']),
              ),
          ],
        ),
      ],
    );
  }

  Color getColorByType(String type) {
    switch (type) {
      case ('bug'):
        return Colors.lightGreen[800];
      case ('electric'):
        return Colors.yellow[800];
      case ('fire'):
        return Colors.redAccent[700];
      case ('grass'):
        return Colors.green[600];
      case ('rock'):
        return Colors.brown;
      case ('dark'):
        return Colors.grey[900];
      case ('fairy'):
        return Colors.pink[100];
      case ('flying'):
        return Colors.lightBlue[200];
      case ('ground'):
        return Colors.brown[200];
      case ('poison'):
        return Colors.purple[700];
      case ('dragon'):
        return Colors.deepPurple;
      case ('fighting'):
        return Colors.red[800];
      case ('ghost'):
        return Colors.purple[900];
      case ('ice'):
        return Colors.lightBlue[200];
      case ('psychic'):
        return Colors.pink;
      case ('water'):
        return Colors.blue;
      default:
        return Colors.brown[200];
    }
  }
}
