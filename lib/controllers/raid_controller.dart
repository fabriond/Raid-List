import 'package:raid_list/models/raid.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/controllers/member_controller.dart';

class RaidController{

  static final groupsRef = Firestore.instance.collection('groups');

  static CollectionReference raidsRef(String groupId){
    return groupsRef.document(groupId).collection('raids');
  }

  static DocumentReference getNewDoc(Raid raid){
    return raidsRef(raid.groupId).document();
  }

  static DocumentReference getDoc(Raid raid){
    return raidsRef(raid.groupId).document(raid.id);
  }

  static CollectionReference membersRef(Raid raid){
    return getDoc(raid).collection('members');
  }

  static Future<void> create(Raid raid) async {
    final doc = getNewDoc(raid);
    raid.id = doc.documentID;
    return doc.setData(raid.toMap());
  }

  static Future<void> update(Raid raid) async {
    final doc = getDoc(raid);
    final raidDoc = await doc.get();
    if(raidDoc.exists){
      return doc.setData(raid.toMap(), merge: true);
    }
  }

  static Future<void> addMember(Raid raid, User newMember) {
    MemberController.create(membersRef(raid), newMember.username, member: {'isReady': false});
  }

  static Future<void> removeMember(Raid raid, User oldMember) {
    MemberController.delete(membersRef(raid), oldMember.username);
  }

  static Future<void> delete(Raid raid) async {
    final doc = getDoc(raid);
    final raidDoc = await doc.get();
    if(raidDoc.exists){
      return doc.delete();
    }
  }

  static Future<void> deleteAllFromGroup(Group group) async {
    final snapshot = await raidsRef(group.id).getDocuments();
    snapshot.documents.forEach((doc) => doc.reference.delete());
  }

}