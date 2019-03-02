import 'package:raid_list/models/group.dart';
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
    bool exists = (await doc.get()).exists;
    if(exists){
      return doc.setData(group.toMap(), merge: true);
    }
  }

  static Future<void> delete(Group group) async {
    final doc = groupsRef.document(group.id);
    bool exists = (await doc.get()).exists;
    if(exists){
      return doc.delete();
    }
  }
}