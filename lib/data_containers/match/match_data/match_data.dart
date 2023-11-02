import 'package:tennis_match_meter/data_containers/match/player.dart';
import 'package:tennis_match_meter/data_containers/match/score_symbols.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/symbols.dart';

class MatchData {
  late Player firstPlayer, secondPlayer, referee;
  late Player leftPlayer, rightPlayer;
  int pointsPlayed = 0;
  int outs = 0;
  int sets = 0;
  late int setsToPlay;
  int servFaults = 0;
  int gems = 1;
  bool finished = false;

  // Flase - left, true - right (opposite on the opponent side)
  bool currentServingSide = false;
  bool isLeftServing = false;

  MatchData(
      {required this.firstPlayer,
      required this.secondPlayer,
      required this.referee,
      this.setsToPlay = 1}) {
    leftPlayer = firstPlayer;
    rightPlayer = secondPlayer;
  }

  MatchData.fromMatchData(MatchData data) {
    firstPlayer = data.firstPlayer;
    secondPlayer = data.secondPlayer;
    referee = data.referee;
    leftPlayer = data.leftPlayer;
    rightPlayer = data.rightPlayer;
    pointsPlayed = data.pointsPlayed;
    outs = data.outs;
    sets = data.sets;
    setsToPlay = data.setsToPlay;
    servFaults = data.servFaults;
    gems = data.gems;
    finished = data.finished;
    currentServingSide = data.currentServingSide;
    isLeftServing = data.isLeftServing;
  }

  bool hasPlayerWonGem(int playerPoints, int opponentPoints) {
    if (playerPoints >= 3 && opponentPoints >= 3) {
      if (playerPoints - opponentPoints >= 2) {
        // Player has won. Opponent has lost.
        return true;
      }
    } else if (playerPoints >= 4 && opponentPoints <= 2) {
      return true;
    }
    return false;
  }

  bool hasPlayerWonSet(int playerGems, int opponentGems) {
    if (playerGems >= 5 && opponentGems >= 5) {
      if (playerGems - opponentGems >= 1) {
        // Player has won. Opponent has lost.
        return true;
      }
    } else if (playerGems >= 6 && opponentGems <= 4) {
      return true;
    }
    return false;
  }

  bool hasGameEnded(int playedSets) {
    return playedSets == setsToPlay;
  }

  int _pointDifference(Player firstPlayer, Player secondPlayer) {
    return firstPlayer.relativeScore() - secondPlayer.relativeScore();
  }

  void finishGem(Player player) {
    player.gemsInSet++;
    player.gemsTotal++;
    gems++;
    leftPlayer.score = 0;
    rightPlayer.score = 0;
    isLeftServing = !isLeftServing;
  }

  void finishSet(Player player) {
    player.sets++;
    sets++;
    leftPlayer.gemsInSet = 0;
    rightPlayer.gemsInSet = 0;
    leftPlayer.score = 0;
    rightPlayer.score = 0;
  }

  void switchPlayers() {
    Player tmp = leftPlayer;
    leftPlayer = rightPlayer;
    rightPlayer = tmp;
    isLeftServing = !isLeftServing;
  }

  ScoreSymbols scoreSymbols() {
    String leftSymbol = leftPlayer.getScore(),
        rightSymbol = rightPlayer.getScore();

    int rellpoints = leftPlayer.relativeScore(),
        relppoints = rightPlayer.relativeScore();

    if (rellpoints >= 3 && relppoints >= 3) {
      int pointDiff = _pointDifference(leftPlayer, rightPlayer);
      if (pointDiff == 0) {
        leftSymbol = Symbols.tie;
        rightSymbol = Symbols.tie;
      } else if (pointDiff == 1) {
        leftSymbol = Symbols.advantage;
        rightSymbol = Symbols.loosing;
      } else if (pointDiff == -1) {
        leftSymbol = Symbols.loosing;
        rightSymbol = Symbols.advantage;
      }
    }

    return ScoreSymbols(
      leftPlayerScoreSymbol: leftSymbol,
      rightPlayerScoreSymbol: rightSymbol,
    );
  }

  void playerOut(bool isLeftPlayer) {
    if (isLeftPlayer) {
      leftPlayer.outs++;
      rightPlayer.addPoint();
    } else {
      rightPlayer.outs++;
      leftPlayer.addPoint();
    }
    leftPlayer.servFaultsInSet = 0;
    rightPlayer.servFaultsInSet = 0;
    outs++;
  }

  void playerPoint(bool isLeftPlayer) {
    if (isLeftPlayer) {
      leftPlayer.addPoint();
    } else {
      rightPlayer.addPoint();
    }
    pointsPlayed++;
    leftPlayer.servFaultsInSet = 0;
    rightPlayer.servFaultsInSet = 0;
    currentServingSide = !currentServingSide;
  }

  void playerservFaults(bool isLeftPlayer) {
    if (isLeftPlayer) {
      leftPlayer.servFaultsInSet++;
      leftPlayer.servFaultsTotal++;
      if (leftPlayer.servFaultsInSet == 2) {
        leftPlayer.servFaultsInSet = 0;
        playerOut(true);
      }
    } else {
      rightPlayer.servFaultsInSet++;
      rightPlayer.servFaultsTotal++;
      if (rightPlayer.servFaultsInSet == 2) {
        rightPlayer.servFaultsInSet = 0;
        playerOut(false);
      }
    }
    servFaults++;
  }
}
