import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_match_meter/account/app_user.dart';
import 'package:tennis_match_meter/data_containers/database/friend.dart';
import 'package:tennis_match_meter/data_containers/match/match_data/match_result.dart';

class DataSource {
  const DataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<MatchResult>> getHistory(String uid) async {
    final history = await _firestore
        .collection('games')
        .where('players', arrayContains: uid)
        .get();
    return history.docs.map(MatchResult.fromSnapshot).toList();
  }

  Stream<List<MatchResult>> get gamesStream => _firestore
      .collection('games')
      .snapshots()
      .map((m) => m.docs.map(MatchResult.fromSnapshot).toList());

  // User is a friend ot his friend
  Future<List<Friend>> getFriends(String uid) async {
    final friends = await _firestore
        .collection('players')
        .where('Friends', arrayContains: uid)
        .get();
    return friends.docs.map(Friend.fromSnapshot).toList();
  }

  Future<void> addFriend(AppUser user, String friendUid) async {
    if (user.uid != friendUid) {
      final friends = await getUsersAsFriends();
      List<dynamic> friendFriends =
          friends.where((element) => element.user.uid == friendUid).toList();
      if (friendFriends.isEmpty ||
          !friendFriends.first.friends.contains(user.uid)) {
        _firestore.collection('players').doc(friendUid).update({
          "Friends": FieldValue.arrayUnion([user.uid])
        });
        _firestore.collection('players').doc(user.uid).update({
          "Friends": FieldValue.arrayUnion([friendUid])
        });
      }
    }
  }

  Future<void> registerNewUser(Friend user) {
    return _firestore
        .collection('players')
        .doc(user.user.uid)
        .set(user.toMap());
  }

  Future<void> deleteFriend(AppUser user, String friendUid) async {
    if (user.uid != friendUid) {
      final friends = await getUsersAsFriends();
      List<dynamic> friendFriends =
          friends.where((element) => element.user.uid == friendUid).toList();
      if (friendFriends.isNotEmpty &&
          friendFriends.first.friends.contains(user.uid)) {
        _firestore.collection('players').doc(friendUid).update({
          "Friends": FieldValue.arrayRemove([user.uid])
        });
        _firestore.collection('players').doc(user.uid).update({
          "Friends": FieldValue.arrayRemove([friendUid])
        });
      }
    }
  }

  Future<List<Friend>> getUsersAsFriends() async {
    final friends = await _firestore.collection('players').get();
    return friends.docs.map(Friend.fromSnapshot).toList();
  }

  Future<void> deleteMatch(String uid, String matchUid) async {
    _firestore.collection('games').doc(matchUid).update({
      "players": FieldValue.arrayRemove([uid])
    });
  }

  Future<void> saveResult(MatchResult result) =>
      _firestore.collection('games').add(result.toMap());

  Stream<List<Friend>> get friendStream => _firestore
      .collection('players')
      .snapshots()
      .map((m) => m.docs.map(Friend.fromSnapshot).toList());
}
