import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/screens/user_edit_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitButton extends StatelessWidget{
  
  final GlobalKey<FormState> formKey;
  final Function saveCallback;

  SubmitButton(this.formKey, this.saveCallback);
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),*/
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Text('Submit', style: TextStyle(color: Colors.white)),

      onPressed: () {
        if (formKey.currentState.validate()) {
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saving...')));
          formKey.currentState.save();
          saveCallback();
          Navigator.pop(context);
        }
      }
    );
  }
}

class DeleteButton extends StatelessWidget {
  
  final GlobalKey<FormState> formKey;
  final Function deleteCallback;

  DeleteButton(this.formKey, this.deleteCallback);

  @override
  Widget build(BuildContext context){
    return RaisedButton(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),*/
      padding: EdgeInsets.all(12),
      color: Colors.redAccent,
      child: Text('Delete', style: TextStyle(color: Colors.white)),

      onPressed: () {
        if (formKey.currentState.validate()) {
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleting...')));
          deleteCallback();
          Navigator.pop(context);
        }
      }
    );
  }
}

class ConfirmButton extends StatelessWidget {
  
  final String text;
  final Function saveCallback;

  ConfirmButton(this.text, this.saveCallback);
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),*/
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Text(text, style: TextStyle(color: Colors.white)),

      onPressed: () {
        saveCallback();
        Navigator.pop(context);
      }
    );
  }
}

class CancelButton extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return RaisedButton(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),*/
      padding: EdgeInsets.all(12),
      color: Colors.blueGrey,
      child: Text('Cancel', style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      }
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create Account',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => UserEditScreen())
      )
    );
  }
}

class LoginButton extends StatelessWidget{
  final GlobalKey<FormState> _formKey;
  final User loginInfo;
  final bool remember;

  LoginButton(this._formKey, this.loginInfo, {this.remember = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),

        onPressed: () async {
          if (_formKey.currentState.validate()) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logging in...')));
            _formKey.currentState.save();
            bool result = await User.login(context, loginInfo);
            if(remember && result) setLoginInfo();
          }
        }        
      ),
    );
  }
  
  void setLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', loginInfo.username);
    prefs.setString('password', loginInfo.password);
  }
}