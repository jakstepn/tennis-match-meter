import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_match_meter/account/app_user.dart';

class Friend {
  AppUser user;
  List<dynamic> friends;
  Friend.user({required this.user, required this.friends});

  static Friend fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Friend.user(
          user: AppUser(
            name: snapshot.data()["Name"],
            uid: snapshot.data()["Uid"],
            age: snapshot.data()["Age"],
            description: snapshot.data()["Description"],
            gender: snapshot.data()["Gender"],
            height: double.parse(snapshot.data()["Height"].toString()),
            level: snapshot.data()["Level"],
            weight: double.parse(snapshot.data()["Weight"].toString()),
          ),
          friends: snapshot.data()["Friends"]);

  Map<String, dynamic> toMap() => {
        'Name': user.name,
        'Uid': user.uid,
        'Age': user.age,
        'Description': user.description,
        'Gender': user.gender,
        'Height': user.height,
        'Level': user.level,
        'Weight': user.weight,
        'Friends': FieldValue.arrayUnion([]),
      };
}
