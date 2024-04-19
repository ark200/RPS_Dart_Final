import 'package:flutter/material.dart';
import 'package:rps_dart/play_page.dart';

class WinningScorePage extends StatefulWidget {
  @override
  _WinningScorePageState createState() => _WinningScorePageState();
}

class _WinningScorePageState extends State<WinningScorePage> {
  final _winningScoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ENTER THE WINNING SCORE'),
            TextField(
              controller: _winningScoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Winning Score'),
            ),
            ElevatedButton(
              onPressed: () {
                int winningScore;
                String winningScoreText = _winningScoreController.text;
                if (winningScoreText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a Winning Score')),
                  );
                } else {
                  winningScore = int.parse(winningScoreText);
                  if (winningScore < 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Minimum Winning Score is 3')),
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>PlayPage(winningScore: winningScore)));
                  }
                }
              },
              child: Text('PROCEED'),
            ),
          ],
        ),
      ),
    );
  }
}