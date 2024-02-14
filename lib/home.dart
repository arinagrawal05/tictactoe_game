import 'game.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff023047),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                radius: 150,
                child: Image.asset("assets/ultimate-tic-tac-toe.png")),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Tic-Tac-Toe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: "Product_Sans",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Game for two players, X and O, who take turns marking the spaces in a 3×3 grid. ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Product_Sans"),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TicGame()));
              },
              child: Center(
                child: Container(
                  height: 45,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text('Start Game',
                        style: TextStyle(color: Colors.white, fontSize: 19)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
