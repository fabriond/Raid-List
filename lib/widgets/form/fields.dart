import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DefaultField extends StatelessWidget {
  
  final Function onSaveCallback;
  final String fieldName;
  final String initValue;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final bool autoFocus;

  DefaultField(this.fieldName, this.onSaveCallback, this.currentFocus, {this.initValue = "", this.autoFocus = false, this.nextFocus});

  TextInputAction setInputAction(){
    if(nextFocus == null){
      return TextInputAction.done;
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
      autofocus: autoFocus,
      initialValue: initValue,
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a ' + fieldName;
        }
      },
      focusNode: currentFocus,
      onFieldSubmitted: (String term){
        if(nextFocus != null){
          currentFocus.unfocus();
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: ReCase(fieldName).titleCase,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3/*2.0*/)),
      ),
    );
  }
}


class PasswordField extends StatefulWidget {

  final Function onSaveCallback;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  PasswordField(this.onSaveCallback, this.currentFocus, {this.nextFocus});

  @override
  State<StatefulWidget> createState() => PasswordFieldState();

}
class PasswordFieldState extends State<PasswordField> {

  bool visibility = false;
  Alignment iconPlacement = Alignment.centerRight;

  void changeIconPlacement(){
    setState(() {
      iconPlacement = Alignment.topRight;
    });
  }

  void changeVisibility(){
    setState(() {
      visibility = !visibility;
    });
  }

  TextInputAction setInputAction(){
    if(widget.nextFocus == null){
      return TextInputAction.done;
    }
    else{
      return TextInputAction.next;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: iconPlacement,
      children: <Widget>[
        TextFormField(
          textInputAction: setInputAction(),
          onSaved: (value) => widget.onSaveCallback(value),
          autofocus: false,
          initialValue: '',
          focusNode: widget.currentFocus,
          validator: (value){
            if(value.isEmpty){
              changeIconPlacement();
              return 'Please enter a password';
            }
          },
          onFieldSubmitted: (String term){
            if(widget.nextFocus != null){
              widget.currentFocus.unfocus();
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          obscureText: !visibility,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3/*2.0*/)),
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