import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<StatefulWidget> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> matrix;
  late String lastChar;

  @override
  void initState() {
    super.initState();
    initMatrix();
  }

  void initMatrix() {
    matrix = List.generate(3, (_) => List.filled(3, ' '));
    lastChar = 'O';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff023047),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Tic tac toe',
          style: TextStyle(
              color: Colors.white, fontFamily: "Product_Sans", fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var j = 0; j < 3; j++) box(i, j),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget box(int i, int j) {
    return GestureDetector(
      onTap: () {
        changeMatrixField(i, j);

        if (checkWinner(i, j)) {
          showResultantDialog(matrix[i][j]);
        } else {
          if (checkDraw()) {
            showResultantDialog(null);
          }
        }
      },
      child: Container(
        width: 110.0,
        height: 110,
        decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white, width: 0.5)),
        child: Center(
          child: Text(
            matrix[i][j],
            style: const TextStyle(fontSize: 92.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void changeMatrixField(int i, int j) {
    setState(() {
      if (matrix[i][j] == ' ') {
        matrix[i][j] = lastChar == 'O' ? 'X' : 'O';
        lastChar = matrix[i][j];
      }
    });
  }

  bool checkDraw() {
    var draw = true;
    for (var row in matrix) {
      if (row.contains(' ')) {
        draw = false;
        break;
      }
    }
    return draw;
  }

  bool checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (int i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i] == player) rdiag++;
    }
    return row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1;
  }

  void showResultantDialog(String? winner) {
    String dialogText = winner == null ? 'It\'s a draw' : 'Player $winner won';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game over'),
          content: Text(dialogText),
          actions: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: const Text('Reset Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    initMatrix();
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }
}
