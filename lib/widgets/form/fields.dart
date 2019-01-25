import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DefaultField extends StatelessWidget {
  
  final Function onSaveCallback;
  final String fieldName;

  DefaultField(this.fieldName, this.onSaveCallback);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      onSaved: (value) => onSaveCallback(value),
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a ' + fieldName;
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: ReCase(fieldName).titleCase,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }
}


class PasswordField extends StatelessWidget {

  final Function onSaveCallback;

  PasswordField(this.onSaveCallback);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => onSaveCallback(value),
      autofocus: false,
      initialValue: '',
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a password';
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  
}