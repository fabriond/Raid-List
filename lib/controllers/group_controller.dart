import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/controllers/member_controller.dart';

class GroupController{
  
  static final groupsRef = Firestore.instance.collection('groups');
  
  static CollectionReference membersRef(String groupId){
    return groupsRef.document(groupId).collection('members');
  }

  static Future<void> create(Group group) async {
    final doc = groupsRef.document();
    group.id = doc.documentID;
    group.memberCount = 0;
    return doc.setData(group.toMap());
  }

  static Future<void> update(Group group) async {
    final doc = groupsRef.document(group.id);
    final grpDoc = await doc.get();
    if(grpDoc.exists){
      return doc.setData(group.toMap(), merge: true);
    }
  }

  static void addMember(Group group, User newMember) {
    newMember.addGroup(group);
    MemberController.create(membersRef(group.id), newMember.username);
    group.memberCount += 1;
    update(group);
  }

  static void removeMember(Group group, User oldMember) {
    oldMember.leaveGroup(group);
    MemberController.delete(membersRef(group.id), oldMember.username);
    group.memberCount -= 1;
    update(group);
  }

  static Future<void> delete(Group group) async {
    final doc = groupsRef.document(group.id);
    final grpDoc = await doc.get();
    if(grpDoc.exists){
      final membersDocs = await membersRef(group.id).getDocuments();
      final members = membersDocs.documents.map((doc) => doc.documentID).toList();
      UserController.rmvGroupFromAll(members, group);
      return doc.delete();
    }
  }

  static void rmvUserFromAll(List<String> groups, User member){
    groups.forEach((g) async {
      MemberController.delete(membersRef(g), member.username);
    });
  }
}