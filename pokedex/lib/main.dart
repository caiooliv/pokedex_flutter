import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const url = '';
void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
          backgroundColor: Colors.red[700],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: FutureBuilder(
          future: getData(6),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.none):
              case (ConnectionState.waiting):
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                } else {
                  Pokemon pokemon = snapshot.data;
                  return ListView(
                    children: <Widget>[
                      Card(
                        child: Row(
                          children: <Widget>[
                            Image.network(pokemon.foto),
                            Text(
                              pokemon.nome,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ));
  }
}

Future<Pokemon> getData(int index) async {
  http.Response response =
      await http.get('https://pokeapi.co/api/v2/pokemon/$index');
  Map teste = (json.decode(response.body));
  Pokemon pokemon =
      Pokemon(nome: teste['name'], foto: teste['sprites']['front_default']);
  return pokemon;
}

List<Pokemon> getInitials(){
  List<Pokemon> initals;
  Future<Pokemon> teste;
  teste = getData(1);
  teste.then((Pokemon onValue) => initals.add(onValue));

  return initals;
}

class Pokemon {
  String nome, foto;

  Pokemon({this.nome, this.foto});
}
