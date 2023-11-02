import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/BLoC/events/add_point_event.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_data.dart';
import 'package:tennis_match_meter/data_containers/match/player.dart';
import 'package:tennis_match_meter/data_containers/match/score_symbols.dart';

class CourtPageBloc extends Bloc<CourtEvent, MatchData> {
  CourtPageBloc(Player p1, Player p2, Player referee)
      : super(MatchData(firstPlayer: p1, secondPlayer: p2, referee: p1)) {
    on<AddPointToLeftPlayerEvent>((event, emit) {
      state.playerPoint(true);
      _checkWinsAndSetSymbols(state.leftPlayer, state.rightPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<AddPointToRightPlayerEvent>((event, emit) {
      state.playerPoint(false);
      _checkWinsAndSetSymbols(state.rightPlayer, state.leftPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<OutPlayerLeftEvent>((event, emit) {
      state.playerOut(true);
      _checkWinsAndSetSymbols(state.rightPlayer, state.leftPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<OutPlayerRightEvent>((event, emit) {
      state.playerOut(false);
      _checkWinsAndSetSymbols(state.leftPlayer, state.rightPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<ServFaultPlayerLeftEvent>((event, emit) {
      state.playerservFaults(true);
      _checkWinsAndSetSymbols(state.rightPlayer, state.leftPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<ServFaultPlayerRightEvent>((event, emit) {
      state.playerservFaults(false);
      _checkWinsAndSetSymbols(state.leftPlayer, state.rightPlayer, state);
      emit(MatchData.fromMatchData(state));
    });
    on<NewGameEvent>((event, emit) {
      emit(event.matchData);
    });
  }
  void onAddPoint(bool isPlayerLeft) {
    if (isPlayerLeft) {
      add(AddPointToLeftPlayerEvent());
    } else {
      add(AddPointToRightPlayerEvent());
    }
  }

  void onOut(bool isPlayerLeft) {
    if (isPlayerLeft) {
      add(OutPlayerLeftEvent());
    } else {
      add(OutPlayerRightEvent());
    }
  }

  void onServFault(bool isPlayerLeft) {
    if (isPlayerLeft) {
      add(ServFaultPlayerLeftEvent());
    } else {
      add(ServFaultPlayerRightEvent());
    }
  }
}

void _checkWinsAndSetSymbols(Player player, Player opponent, MatchData state) {
  _checkWins(player, opponent, state);
  _setPlayerSymbols(state);
}

void _checkWins(Player player, Player opponent, MatchData curGame) {
  bool gemWon = _checkIfGem(player, opponent, curGame);
  _checkIfSet(player, opponent, curGame);
  _checkIfWon(curGame.sets, curGame);
  if (gemWon && curGame.gems % 2 == 0) {
    curGame.switchPlayers();
  }
}

void _setPlayerSymbols(MatchData curGame) {
  ScoreSymbols symbols = curGame.scoreSymbols();
  curGame.leftPlayer.symbol = symbols.leftPlayerScoreSymbol;
  curGame.rightPlayer.symbol = symbols.rightPlayerScoreSymbol;
}

void _checkIfWon(int playedSets, MatchData curGame) {
  if (curGame.hasGameEnded(playedSets)) {
    curGame.finished = true;
  }
}

bool _checkIfGem(Player player, Player opponent, MatchData curGame) {
  if (curGame.hasPlayerWonGem(
      player.relativeScore(), opponent.relativeScore())) {
    curGame.finishGem(player);
    return true;
  }
  return false;
}

bool _checkIfSet(Player player, Player opponent, MatchData curGame) {
  if (curGame.hasPlayerWonSet(player.gemsInSet, opponent.gemsInSet)) {
    curGame.finishSet(player);
    return true;
  }
  return false;
}
