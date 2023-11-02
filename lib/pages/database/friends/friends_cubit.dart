import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/pages/authentication/auth_cubit.dart';
import 'package:tennis_match_meter/database/data_source.dart';
import 'package:tennis_match_meter/data_containers/database/friend.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit({required DataSource shoutboxDataSource})
      : _dataSource = shoutboxDataSource,
        super(const FriendsInitialState()) {
    _sub = _dataSource.friendStream.listen(
        (friends) => emit(FriendsLoadedState(friends: friends.toList())));
  }

  final DataSource _dataSource;
  late final StreamSubscription _sub;

  Future<void> getFriends(BuildContext context) async {
    String uid = context.read<AuthCubit>().authService.getUserUID();
    final friends = await _dataSource.getFriends(uid);
    emit(FriendsLoadedState(
      friends: friends.toList(),
    ));
  }

  Future<void> getUsers(String currentUserUid) async {
    final friends = await _dataSource.getUsersAsFriends();
    emit(AllUsersLoadedState(
      allUsers: friends.toList()
        ..removeWhere(
          (element) => element.user.uid == currentUserUid,
        ),
    ));
  }

  Future<void> getAllUsers() async {
    final friends = await _dataSource.getUsersAsFriends();
    emit(AllUsersLoadedState(
      allUsers: friends.toList(),
    ));
  }

  Future<void> addFriend(AppUser user, String friendUid) async {
    _dataSource.addFriend(user, friendUid);
  }

  Future<void> deleteFriend(AppUser user, String friendUid) async {
    _dataSource.deleteFriend(user, friendUid);
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}

abstract class FriendsState {
  const FriendsState();
}

class FriendsInitialState extends FriendsState {
  const FriendsInitialState();
}

class FriendsLoadedState extends FriendsState {
  const FriendsLoadedState({
    required this.friends,
  });

  final List<Friend> friends;
}

class AllUsersLoadedState extends FriendsState {
  const AllUsersLoadedState({
    required this.allUsers,
  });

  final List<Friend> allUsers;
}
