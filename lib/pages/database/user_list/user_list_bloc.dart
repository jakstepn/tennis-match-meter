import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_list_event.dart';
import 'package:tennis_match_meter/pages/database/user_list/user_tile_click_event.dart';
import 'package:tennis_match_meter/account/app_user.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc({UserListState initialState = const UserListInitialState()})
      : super(initialState) {
    on<UserListStartSelectingEvent>((event, emit) {
      emit(UserListSelectState());
    });
    on<UserListStopSelectingEvent>((event, emit) {
      emit(const UserListInitialState());
    });
    on<UserListStartAddingFriendsEvent>((event, emit) {
      emit(UserListAddFriendState());
    });
    on<UserListStartDeletingFriendsEvent>((event, emit) {
      emit(UserListDeleteFriendState());
    });
  }
}

abstract class UserListState {
  const UserListState();
}

class UserListInitialState extends UserListState {
  const UserListInitialState();
}

class UserListSelectState extends UserListState {
  UserListSelectState();
}

class UserListAddFriendState extends UserListState {
  UserListAddFriendState();
}

class UserListDeleteFriendState extends UserListState {
  UserListDeleteFriendState();
}

class UserListTileBloc extends Bloc<UserListTileEvent, List<AppUser>> {
  UserListTileBloc() : super(List<AppUser>.empty()) {
    tiles = List<AppUser>.empty(growable: true);
    on<UserListTileClick>((event, emit) {
      if (!tiles.remove(event.user) && (event.notlimited || tiles.length < 2)) {
        tiles.add(event.user);
      }
      emit(tiles);
    });
    on<UserListTileReset>((event, emit) {
      tiles.clear();
      emit(tiles);
    });
  }
  late List<AppUser> tiles;
}
