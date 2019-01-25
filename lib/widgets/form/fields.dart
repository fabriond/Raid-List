import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DefaultField extends StatelessWidget {
  
  final Function onSaveCallback;
  final String fieldName;
  final bool isLast;


  DefaultField(this.fieldName, this.isLast, this.onSaveCallback);

  TextInputAction setInputAction(){
    if(isLast){
      return TextInputAction.none;
    }
    else{
      return TextInputAction.next;
    }
  }

  @override
  Widget build(BuildContext context){
    return TextFormField(
      textInputAction: setInputAction(),
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


class PasswordField extends StatefulWidget {

  final Function onSaveCallback;

  PasswordField(this.onSaveCallback);

  @override
  State<StatefulWidget> createState() => PasswordFieldState();

}
class PasswordFieldState extends State<PasswordField> {

  bool visibility = false;

  void changeVisibility(){
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        TextFormField(
          textInputAction: TextInputAction.none,
          onSaved: (value) => widget.onSaveCallback(value),
          autofocus: false,
          initialValue: '',
          validator: (value){
            if(value.isEmpty){
              return 'Please enter a password';
            }
          },
          obscureText: !visibility,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
        IconButton(
          icon: Icon(Icons.visibility),
          onPressed: changeVisibility,
        )
      ]
    );
  }

  
}