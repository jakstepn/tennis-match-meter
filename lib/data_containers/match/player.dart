import 'package:tennis_match_meter/account/app_user.dart';

class Player {
  late String playerID;
  late String name;
  late String symbol;
  late int score;
  int outs = 0;
  int servFaultsInSet = 0;
  int servFaultsTotal = 0;
  int gemsTotal = 0;
  int gemsInSet = 0;
  int sets = 0;
  Player({required this.name, this.score = 0, required this.playerID}) {
    symbol = getScore();
  }

  Player.fromUser(AppUser user) {
    playerID = user.uid;
    name = user.name;
    score = 0;
    symbol = getScore();
  }

  void addPoint() {
    score += 15;
  }

  String getScore() {
    if (score == 45) {
      return "40";
    } else {
      return score.toString();
    }
  }

  int relativeScore() {
    return score ~/ 15;
  }
}
