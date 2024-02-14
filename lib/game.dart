import 'package:flutter/material.dart';

class TicGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TicGameState();
}

class _TicGameState extends State<TicGame> {
  late List<List<String>> _matrix;
  late String _lastChar;

  @override
  void initState() {
    super.initState();
    _initMatrix();
  }

  void _initMatrix() {
    _matrix = List.generate(3, (_) => List.filled(3, ' '));
    _lastChar = 'O';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023047),
      appBar: AppBar(
        iconTheme: IconThemeData(
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
      body: Container(
        // padding: EdgeInsets.all(20),
        // color: Colors.blueAccent,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var j = 0; j < 3; j++) _buildElement(i, j),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);

        if (_checkWinner(i, j)) {
          _showDialog(_matrix[i][j]);
        } else {
          if (_checkDraw()) {
            _showDialog(null);
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
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        _matrix[i][j] = _lastChar == 'O' ? 'X' : 'O';
        _lastChar = _matrix[i][j];
      }
    });
  }

  bool _checkDraw() {
    var draw = true;
    for (var row in _matrix) {
      if (row.contains(' ')) {
        draw = false;
        break;
      }
    }
    return draw;
  }

  bool _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - i] == player) rdiag++;
    }
    return row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1;
  }

  void _showDialog(String? winner) {
    String dialogText = winner == null ? 'It\'s a draw' : 'Player $winner won';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game over'),
          content: Text(dialogText),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Reset Game'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initMatrix();
                });
              },
            )
          ],
        );
      },
    );
  }
}
