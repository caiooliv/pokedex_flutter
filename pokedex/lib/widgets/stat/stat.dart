import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Stat extends StatelessWidget {
  const Stat({Key key, this.type, this.value, this.pokemonType})
      : super(key: key);
  final type;
  final value;
  final pokemonType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                type,
                style: GoogleFonts.pressStart2P(fontSize: 15),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: GoogleFonts.pressStart2P(fontSize: 15),
              )),
        ),
        Flexible(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 10,
              width: 100,
              color: Colors.grey[300],
              child: FractionallySizedBox(
                  heightFactor: 1.0,
                  widthFactor: transformValue(value),
                  child: Container(
                    color: getColorByType(pokemonType),
                  )),
            ),
            //child: ,
          ),
        )
      ],
    );
  }

  double transformValue(value) {
    double transformedValue = ((value * 100) / 170) / 100;
    return transformedValue;
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
      case ('steel'):
        return Colors.teal[500];
      default:
        return Colors.brown[200];
    }
  }
}
