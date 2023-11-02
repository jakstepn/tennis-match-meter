import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';

abstract class CourtEvent {}

class AddPointToLeftPlayerEvent extends CourtEvent {}

class AddPointToRightPlayerEvent extends CourtEvent {}

class OutPlayerLeftEvent extends CourtEvent {}

class OutPlayerRightEvent extends CourtEvent {}

class ServFaultPlayerLeftEvent extends CourtEvent {}

class ServFaultPlayerRightEvent extends CourtEvent {}

class NewGameEvent extends CourtEvent {
  NewGameEvent({required this.matchData});
  final MatchData matchData;
}
