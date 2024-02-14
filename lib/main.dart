import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
      title: "Tictactoe Game",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Home(),
    ));
