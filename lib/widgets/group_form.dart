import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupForm extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<GroupFormState>!
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> group;

  GroupForm({this.group});

  void _saveGroup(){
    final groupsRef = Firestore.instance.collection('groups');
    if(!group.containsKey('id')){
      final ref = groupsRef.document();
      group.putIfAbsent('id', () => ref.documentID);
      ref.setData(group);
    } else {
      final ref = groupsRef.document(group['id']);
      ref.setData(group, merge: true);
    }
  }

  void _deleteGroup(){
    final ref = Firestore.instance.collection('groups').document(group['id']);
    ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          textField('title', 'title'),
          textField('bossName', 'boss name'),
          formButtons(context)
        ]
      )
    );
  }

  Widget textField(String name, String formalName){
    return TextFormField(
      onSaved: (value) => group.update(name, (oldValue) => value, ifAbsent: () => value),
      initialValue: this.group[name],
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a ' + formalName;
        }
      }
    );
  }

  Widget formButtons(BuildContext context){
    if(group == null || group.isEmpty){
      return submitButton(context);
    } else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          submitButton(context),
          deleteButton(context)
        ]
      );
    }
  }

  Widget submitButton(BuildContext context){
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Creating Group...')));
          _formKey.currentState.save();
          _saveGroup();
          Navigator.pop(context);
        }
      }
    );
  }

  Widget deleteButton(BuildContext context){
    return RaisedButton(
      child: Text('Delete'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleting Group...')));
          _deleteGroup();
          Navigator.pop(context);
        }
      }
    );
  }
}