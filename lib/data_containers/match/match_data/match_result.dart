import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';

class MatchResult {
  MatchResult({
    required this.firstPlayerName,
    required this.secondPlayerName,
    required this.refereeName,
    required this.uid,
    this.pointsPlayed = 0,
    this.outsFirstPlayer = 0,
    this.outsSecondPlayer = 0,
    this.setsFirstPlayer = 0,
    this.setsSecondPlayer = 0,
    this.gemsFirstPlayer = 0,
    this.gemsSecondPlayer = 0,
    this.servFaultsFirstPlayer = 0,
    this.servFaultsSecondPlayer = 0,
    this.firstPlayerID = "",
    this.secondPlayerID = "",
    this.refereeID = "",
  });

  MatchResult.fromData(MatchData data) {
    firstPlayerName = data.firstPlayer.name;
    secondPlayerName = data.secondPlayer.name;
    refereeName = data.referee.name;
    firstPlayerID = data.firstPlayer.playerID;
    secondPlayerID = data.secondPlayer.playerID;
    refereeID = data.referee.playerID;
    pointsPlayed = data.pointsPlayed;
    outsFirstPlayer = data.firstPlayer.outs;
    outsSecondPlayer = data.secondPlayer.outs;
    setsFirstPlayer = data.firstPlayer.sets;
    setsSecondPlayer = data.secondPlayer.sets;
    servFaultsFirstPlayer = data.firstPlayer.servFaultsTotal;
    servFaultsSecondPlayer = data.secondPlayer.servFaultsTotal;
    gemsFirstPlayer = data.firstPlayer.gemsTotal;
    gemsSecondPlayer = data.secondPlayer.gemsTotal;
    tmp.add(firstPlayerID);
    tmp.add(secondPlayerID);
    tmp.add(refereeID);
  }
  late String firstPlayerName,
      secondPlayerName,
      refereeName,
      firstPlayerID,
      secondPlayerID,
      refereeID,
      uid;
  late int pointsPlayed,
      outsFirstPlayer,
      outsSecondPlayer,
      setsFirstPlayer,
      setsSecondPlayer,
      servFaultsFirstPlayer,
      servFaultsSecondPlayer,
      gemsFirstPlayer,
      gemsSecondPlayer;
  List<String> tmp = List<String>.empty(growable: true);

  static MatchResult fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      MatchResult(
        uid: snapshot.id,
        firstPlayerName: snapshot.data()['firstPlayerName'],
        secondPlayerName: snapshot.data()['secondPlayerName'],
        refereeName: snapshot.data()['refereeName'],
        gemsFirstPlayer: snapshot.data()['gemsTotalFirstPlayer'],
        gemsSecondPlayer: snapshot.data()['gemsTotalSecondPlayer'],
        outsFirstPlayer: snapshot.data()['outsFirstPlayer'],
        outsSecondPlayer: snapshot.data()['outsSecondPlayer'],
        pointsPlayed: snapshot.data()['pointsPlayed'],
        servFaultsFirstPlayer: snapshot.data()['servFaultsTotalFirstPlayer'],
        servFaultsSecondPlayer: snapshot.data()['servFaultsTotalSecondPlayer'],
        setsFirstPlayer: snapshot.data()['setsFirstPlayer'],
        setsSecondPlayer: snapshot.data()['setsSecondPlayer'],
      );

  Map<String, dynamic> toMap() => {
        'players': FieldValue.arrayUnion(tmp),
        'firstPlayerName': firstPlayerName,
        'secondPlayerName': secondPlayerName,
        'refereeName': refereeName,
        'gemsTotalFirstPlayer': gemsFirstPlayer,
        'gemsTotalSecondPlayer': gemsSecondPlayer,
        'outsFirstPlayer': outsFirstPlayer,
        'outsSecondPlayer': outsSecondPlayer,
        'pointsPlayed': pointsPlayed,
        'servFaultsTotalFirstPlayer': servFaultsFirstPlayer,
        'servFaultsTotalSecondPlayer': servFaultsSecondPlayer,
        'setsFirstPlayer': setsFirstPlayer,
        'setsSecondPlayer': setsSecondPlayer,
      };
}
