import 'package:flutter/material.dart';
import 'package:pokedex/screens/home_page/home_page.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red[400],
    ),
    home: HomePage(),
  ));
}