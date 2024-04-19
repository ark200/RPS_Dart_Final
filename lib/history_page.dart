import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database_helper2.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>>? _gameLogs;
  List<Widget>? _gameLogWidgets;
  final Database2Helper _databaseHelper = Database2Helper.instance;

  @override
  void initState() {
    super.initState();
    _loadGameLogs();
  }

  Future<void> _loadGameLogs() async {
    final db = await _databaseHelper.database;
    final gameLogs = await db.query(Database2Helper.table);
    setState(() {
      _gameLogs = gameLogs;
      _gameLogWidgets = _gameLogs?.map((log) {
        final date =
        DateTime.fromMillisecondsSinceEpoch(log[Database2Helper.date]);
        final formattedDate = DateFormat.yMd().add_jm().format(date);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: $formattedDate'),
            Text('Result: ${log[Database2Helper.result]}'),
            Text('My Score: ${log[Database2Helper.myScore]}'),
            Text('Opponent Score: ${log[Database2Helper.oppScore]}'),
          ],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: _gameLogWidgets ?? [],
        ),
      ),
    );
  }
}
