import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'database_helper2.dart';
import 'gameutils.dart';

class PlayPage extends StatefulWidget {
  final int winningScore;

  PlayPage({required this.winningScore});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  GameUtils? gameUtils;
  int myScore = 0;
  int oppScore = 0;
  String result = '';
  final dbHelper = Database2Helper.instance;

  @override
  void initState() {
    super.initState();
    gameUtils = GameUtils(widget.winningScore);
  }

  void updateUI(String newResult, int newMyScore, int newOppScore) {
    setState(() {
      result = newResult;
      myScore = newMyScore;
      oppScore = newOppScore;
    });

    if (myScore >= widget.winningScore || oppScore >= widget.winningScore) {
      saveRecord();
      _showDialog();
    }
  }

  Future<void> saveRecord() async {
    final db = await dbHelper.database;
    final date = DateTime.now();


    final record = {
      Database2Helper.date: date,
      Database2Helper.myScore: myScore,
      Database2Helper.oppScore: oppScore,
      Database2Helper.result: result,
    };

    await db.insert(Database2Helper.table, record);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $myScore, Opponent score: $oppScore'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/homepage');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newResult = gameUtils!.play('rock');
                updateUI(newResult, gameUtils!.myScore, gameUtils!.oppScore);
              },
              child: Text('Rock'),
            ),
            ElevatedButton(
              onPressed: () {
                final newResult = gameUtils!.play('paper');
                updateUI(newResult, gameUtils!.myScore, gameUtils!.oppScore);
              },
              child: Text('Paper'),
            ),
            ElevatedButton(
              onPressed: () {
                final newResult = gameUtils!.play('scissors');
                updateUI(newResult, gameUtils!.myScore, gameUtils!.oppScore);
              },
              child: Text('Scissors'),
            ),
            SizedBox(height: 20),
            Text('User Score: $myScore'),
            Text('Opponent Score: $oppScore'),
          ],
        ),
      ),
    );
  }
}