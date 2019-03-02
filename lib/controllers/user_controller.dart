import 'package:raid_list/models/user.dart';
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
    bool exists = (await doc.get()).exists;
    if(exists){
      return doc.delete();
    }
  }
}