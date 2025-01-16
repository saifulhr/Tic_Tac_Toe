import 'package:flutter/material.dart';

class TicTac extends StatefulWidget {
  const TicTac({super.key});

  @override
  State<TicTac> createState() => _TicTacState();
}

class _TicTacState extends State<TicTac> {
  // borderstate to keep track of moves??
  final List<String> board = List.filled(9, '');
  // current players x or o
  String currentPlayer = 'X';
  // Variable to store the winner??
  String winner = '';
  // Flag to indicate a tie
  bool isTie = false;
  // function to handle a player,s move
  player(int index) {
    if (winner != '' || board[index] != '') {
      return;
    }
    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      checkForWinner();
    });
  }

// for afunction win or tie??
  checkForWinner() {
    List<List<int>> lins = [
      [0, 1, 2],
      [3, 4, 5],
      [7, 6, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    // check each winning combination??
    for (List<int> line in lins) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if (player1 == '' || player2 == '' || player3 == '') {
        continue;
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner = player1;
        });
        return;
      }
    }
    // check for tie??
    if (!board.contains('')) {
      setState(() {
        isTie = true;
      });
    }
  }

  resetGame() {
    setState(() {
      board.fillRange(0, 9, '');
      currentPlayer = 'X';
      winner = '';
      isTie = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF505d7d),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == 'X'
                          ? Color(0xfffc5723)
                          : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      )
                    ],
                    color: Color(0xff292c39)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xffdee9e5),
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'BOT 1',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff3ece4)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'X',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8ec97b)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == 'O'
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      )
                    ],
                    color: Color(0xff272c39)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xffdee9e5),
                        size: 55,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'BOT 2',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff3ece4)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'O',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8ec97b)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          // Display the winner msg??
          if (winner != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                Text(
                  ' - You Won',
                  style: TextStyle(
                      color: Color(0xfffc5723),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )
              ],
            ),
          // display the tie section??
          if (isTie)
            Text(
              'It\'s a Tie Match!',
              style: TextStyle(
                  color: Colors.red, fontSize: 27, fontWeight: FontWeight.bold),
            ),

          //number contaier scetion??
          Padding(
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: 9,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFd3ddda),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style:
                            TextStyle(fontSize: 50, color: Color(0xff231934)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Reset button??
          if (winner != '' || isTie)
            ElevatedButton(
                onPressed: resetGame,
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black)),
                child: Text(
                  'Play Again',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
        ],
      ),
    );
  }
}
