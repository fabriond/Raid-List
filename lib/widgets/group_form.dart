import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:raid_list/models/user.dart';

class GroupForm extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<GroupFormState>!
  final _formKey = GlobalKey<FormState>();
  final Group group;
  final User user;

  GroupForm(this.user, {this.group});

  void _saveGroup(){
    final groupsRef = Firestore.instance.collection('groups');
    if(group.id == null){
      final ref = groupsRef.document();
      group.id = ref.documentID;
      group.addMember(user);
      ref.setData(group.toMap());
    } else {
      final ref = groupsRef.document(group.id);
      ref.setData(group.toMap(), merge: true);
    }
  }

  void _deleteGroup(){
    final ref = Firestore.instance.collection('groups').document(group.id);
    ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DefaultField('location', false, (value) => group.location = value),
          SizedBox(height: 8.0),
          DefaultField('boss', true, (value) => group.boss = value),
          SizedBox(height: 8.0),
          formButtons(context)
        ]
      )
    );
  }

  Widget formButtons(BuildContext context){
    if(group.id == null){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SubmitButton(_formKey, _saveGroup),
          SizedBox(width: 16.0),
          CancelButton()
        ]
      );
    } else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SubmitButton(_formKey, _saveGroup),
          SizedBox(width: 16.0),
          DeleteButton(_formKey, _deleteGroup)
        ]
      );
    }
  }
}