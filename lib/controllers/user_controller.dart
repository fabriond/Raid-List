import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/controllers/group_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController{
  
  static final usersRef = Firestore.instance.collection('users');

  static Future<void> create(User user) async {
    final doc = usersRef.document(user.username);
    bool exists = (await doc.get()).exists;
    if(!exists){
      return doc.setData(user.toMap());
    }
  }

  static Future<void> update(User user) async {
    final doc = usersRef.document(user.username);
    bool exists = (await doc.get()).exists;
    if(exists){
      return doc.setData(user.toMap(), merge: true);
    }
  }

  static Future<void> delete(User user) async {
    final doc = usersRef.document(user.username);
    final usrDoc = await doc.get();
    if(usrDoc.exists){
      final usr = User.fromMap(usrDoc.data);
      GroupController.rmvUserFromAll(usr.groups, user);
      return doc.delete();
    }
  }

  static void rmvGroupFromAll(List<String> members, Group group){
    members.forEach((m) async {
      final doc = await usersRef.document(m).get();
      User.fromMap(doc.data).leaveGroup(group);
    });
  }
}