import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:password/password.dart';

class UserForm extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<UserFormState>!
  static final _formKey = GlobalKey<FormState>();
  final User user = User();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  void _saveUser(){
    user.password = Password.hash(user.password, PBKDF2(iterationCount: 100));
    final usersRef = Firestore.instance.collection('users');
    final usr = usersRef.document(user.username).get();
    usr.then((doc) {
      if(!doc.exists){
        final ref = usersRef.document(user.username);
        ref.setData(user.toMap());
      } else{
        Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(content: Text('Username taken')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DefaultField('username', (value) => user.username = value, usernameFocus, nextFocus: passwordFocus),
          SizedBox(height: 8.0),
          PasswordField((value) => user.password = value, passwordFocus),
          SizedBox(height: 8.0),
          formButtons(context)
        ]
      )
    );
  }

  Widget formButtons(BuildContext context){
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        SubmitButton(_formKey, _saveUser),
        CancelButton()
      ]
    );
  }
}