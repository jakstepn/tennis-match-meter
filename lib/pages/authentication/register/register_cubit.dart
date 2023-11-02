import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_match_meter/data_containers/database/friend.dart';
import 'package:tennis_match_meter/database/data_source.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required DataSource shoutboxDataSource})
      : _dataSource = shoutboxDataSource,
        super(const RegisterInitialState()) {
    _sub = _dataSource.friendStream
        .listen((users) => emit(RegisterLoadedState(users: users.toList())));
  }

  final DataSource _dataSource;
  late final StreamSubscription _sub;

  Future<void> registerNewUser(Friend user) async {
    _dataSource.registerNewUser(user);
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

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}

abstract class RegisterState {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadedState extends RegisterState {
  const RegisterLoadedState({
    required this.users,
  });

  final List<Friend> users;
}

class AllUsersLoadedState extends RegisterState {
  const AllUsersLoadedState({
    required this.allUsers,
  });

  final List<Friend> allUsers;
}
