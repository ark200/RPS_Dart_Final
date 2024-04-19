import 'dart:math';

class GameUtils {
  int _winningScore;
  int _myScore = 0;
  int _oppScore = 0;
  String? _myMove;
  String? _oppMove;
  final _random = Random();

  GameUtils(this._winningScore);

  String play(String move) {
    _myMove = move;
    _oppMove = getOpponentMove();
    return getResult();
  }

  String getOpponentMove() {
    List<String> moves = ["Rock", "Paper", "Scissors"];
    int index = _random.nextInt(moves.length);
    return moves[index];
  }

  String getResult() {
    if (_myMove == _oppMove) {
      return "Tie";
    } else if ((_myMove == "Rock" && _oppMove == "Scissors") ||
        (_myMove == "Paper" && _oppMove == "Rock") ||
        (_myMove == "Scissors" && _oppMove == "Paper")) {
      _myScore++;
      return "You Win";
    } else {
      _oppScore++;
      return "Opponent Wins";
    }
  }

  int get myScore => _myScore;

  int get oppScore => _oppScore;

  int get winningScore => _winningScore;

  String get gameResult {
    if (_myScore >= _winningScore) {
      return "YOU WIN";
    } else if (_oppScore >= _winningScore) {
      return "OPPONENT WINS";
    } else {
      return "GAME IN PROGRESS";
    }
  }
}
