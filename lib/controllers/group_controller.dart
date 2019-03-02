import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupController{
  
  static final groupsRef = Firestore.instance.collection('groups');

  static Future<void> create(Group group) async {
    final doc = groupsRef.document();
    group.id = doc.documentID;
    return doc.setData(group.toMap());
  }

  static Future<void> update(Group group) async {
    final doc = groupsRef.document(group.id);
    final grpDoc = await doc.get();
    if(grpDoc.exists){
      return doc.setData(group.toMap(), merge: true);
    }
  }

  static Future<void> delete(Group group) async {
    final doc = groupsRef.document(group.id);
    final grpDoc = await doc.get();
    if(grpDoc.exists){
      final grp = Group.fromMap(grpDoc.data);
      UserController.rmvGroupFromAll(grp.members, group);
      return doc.delete();
    }
  }

  static void rmvUserFromAll(List<String> groups, User member){
    groups.forEach((g) async {
      final doc = await groupsRef.document(g).get();
      Group.fromMap(doc.data).removeMember(member);
    });
  }
}