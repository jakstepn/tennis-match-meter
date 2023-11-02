abstract class UserListEvent {
  UserListEvent();
}

class UserListStartSelectingEvent extends UserListEvent {
  UserListStartSelectingEvent();
}

class UserListStopSelectingEvent extends UserListEvent {
  UserListStopSelectingEvent();
}

class UserListStartAddingFriendsEvent extends UserListEvent {
  UserListStartAddingFriendsEvent();
}

class UserListStartDeletingFriendsEvent extends UserListEvent {
  UserListStartDeletingFriendsEvent();
}
