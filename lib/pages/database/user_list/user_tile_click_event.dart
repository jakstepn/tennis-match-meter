import 'package:tennis_match_meter/account/app_user.dart';

abstract class UserListTileEvent {
  UserListTileEvent();
}

class UserListTileClick extends UserListTileEvent {
  UserListTileClick({required this.user, this.notlimited = false});
  final AppUser user;
  final bool notlimited;
}

class UserListTileReset extends UserListTileEvent {
  UserListTileReset();
}
