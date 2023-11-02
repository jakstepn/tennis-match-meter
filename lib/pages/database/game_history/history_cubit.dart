import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';
import 'package:tennis_match_meter/database/data_source.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({required DataSource shoutboxDataSource})
      : _historyDataSource = shoutboxDataSource,
        super(const HistoryInitialState()) {
    _sub = _historyDataSource.gamesStream
        .listen((games) => emit(HistoryLoadedState(history: games.toList())));
  }

  final DataSource _historyDataSource;
  late final StreamSubscription _sub;

  Future<void> getHistory(String uid) async {
    final history = await _historyDataSource.getHistory(uid);
    emit(HistoryLoadedState(
      history: history.toList(),
    ));
  }

  Future<void> deleteMatch(String uid, String matchUid) async {
    await _historyDataSource.deleteMatch(uid, matchUid);
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}

abstract class HistoryState {
  const HistoryState();
}

class HistoryInitialState extends HistoryState {
  const HistoryInitialState();
}

class HistoryLoadedState extends HistoryState {
  const HistoryLoadedState({
    required this.history,
  });

  final List<MatchResult> history;
}
