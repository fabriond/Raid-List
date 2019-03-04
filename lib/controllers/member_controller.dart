import 'package:cloud_firestore/cloud_firestore.dart';

class MemberController{

  static Future<void> create(CollectionReference membersRef, String id, {Map<String, dynamic> member}) async {
    if(id != null){
      final doc = membersRef.document(id);
      final memberDoc = await doc.get();
      if(!memberDoc.exists){
        return doc.setData(member ?? {});
      }
    }
  }

  static Future<void> update(CollectionReference membersRef, String id, Map<String, dynamic> member) async {
    if(id != null){
      final doc = membersRef.document(id);
      final memberDoc = await doc.get();
      if(memberDoc.exists){
        return doc.setData(member, merge: true);
      }
    }
  }

  static Future<void> delete(CollectionReference membersRef, String id) async {
    if(id != null){
      final doc = membersRef.document(id);
      final memberDoc = await doc.get();
      if(memberDoc.exists){
        return doc.delete();
      }
    }
  }
}