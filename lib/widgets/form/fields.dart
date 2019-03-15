import 'package:http/http.dart' show Client;
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

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
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        fillColor: Theme.of(context).dialogBackgroundColor,
        filled: true,
        labelText: ReCase(fieldName).titleCase,
        labelStyle: TextStyle(fontSize: 18),
        contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 14.0),
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

  Icon getIcon(){
    if(visibility) return Icon(Icons.visibility_off);
    else return Icon(Icons.visibility);
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
    return TextFormField(
      textInputAction: setInputAction(),
      onSaved: (value) => widget.onSaveCallback(value),
      autofocus: false,
      initialValue: '',
      focusNode: widget.currentFocus,
      validator: (value){
        if(value.isEmpty){
          return 'Please enter a password';
        }
      },
      onFieldSubmitted: (String term){
        if(widget.nextFocus != null){
          widget.currentFocus.unfocus();
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
      },
      style: TextStyle(fontSize: 18),
      obscureText: !visibility,
      decoration: InputDecoration(
        fillColor: Theme.of(context).dialogBackgroundColor,
        filled: true,
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 18),
        contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 14.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3/*2.0*/)),
        suffixIcon: IconButton(
          icon: getIcon(),
          onPressed: changeVisibility,
        )
      ),
    );
  }

}

class TimeField extends StatelessWidget{

  final String fieldName;
  final Function onSaveCallback;
  final DateTime initValue;
  final bool autoFocus;
  final FocusNode currentFocus;
  final FocusNode nextFocus;

  TimeField(this.fieldName, this.onSaveCallback, this.currentFocus, {this.initValue, this.autoFocus = false, this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return DateTimePickerFormField(
      dateOnly: false,
      format: DateFormat.yMMMd().addPattern("'at'").add_jm(),
      onSaved: (value) => onSaveCallback(value),
      keyboardType: TextInputType.text,
      autofocus: autoFocus,
      editable: false,
      initialValue: initValue,
      validator: (value){
        if(value == null){
          return 'Please enter a ' + fieldName;
        }
      },
      focusNode: currentFocus,
      onFieldSubmitted: (DateTime term){
        if(nextFocus != null){
          currentFocus.unfocus();
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        fillColor: Theme.of(context).dialogBackgroundColor,
        filled: true,
        labelText: ReCase(fieldName).titleCase,
        labelStyle: TextStyle(fontSize: 18),
        contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 14.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3/*2.0*/)),
      ),
    );
  }
}

class RaidBossDropdown extends StatefulWidget{

  final Client client = Client();
  final Function onSaveCallback;
  final String initValue;

  RaidBossDropdown(this.onSaveCallback, {this.initValue});

  @override
  State<StatefulWidget> createState() => _BossDropdownState(currentValue: initValue);

}
class _BossDropdownState extends State<RaidBossDropdown> {

  String currentValue;
  bool selected = false;

  _BossDropdownState({this.currentValue});

  Future<List<String>> getBosses() async {
    final resp = await widget.client.get('https://thesilphroad.com/raid-bosses');
    final bossDiv = RegExp('<div class="boss-name">\.*</div>');
    return bossDiv.allMatches(resp.body)
                  .map((m) => m.group(0).replaceFirst('<div class="boss-name">', '').replaceFirst('</div>', ''))
                  .toList();
  }

  List<String> initData(){
    if(currentValue != null && !selected) return [currentValue];
    else return [];
  }

  List<String> availableBosses(List<String> currentBosses){
    List<String> bosses = [];
    if(!currentBosses.any((boss) => initData().contains(boss))){
      bosses += initData(); // happens in case the raid's boss is no longer in the rotation
    }
    bosses += currentBosses;
    return bosses;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      initialData: initData(),
      future: getBosses(),
      builder: (context, snapshot) {
        final bosses = availableBosses(snapshot.data).map((boss) {
          return DropdownMenuItem(value: boss, child: Text(boss, style: TextStyle(fontSize: 18)));
        }).toList();

        return DropdownButtonFormField<String>(
          value: currentValue,
          items: bosses,
          onChanged: (value) {
            setState(() {
              if(!initData().contains(value)) selected = true;
              currentValue = value;
            });
          },
          onSaved: (value) => widget.onSaveCallback(value),
          validator: (value){
            if(value == null){
              return 'Please select a boss';
            } else if(value.isEmpty){
              return 'Please select a boss';
            }
          },
          decoration: InputDecoration(
            fillColor: Theme.of(context).dialogBackgroundColor,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3/*2.0*/)),
            labelText: ReCase('boss').titleCase,
            labelStyle: TextStyle(fontSize: 18)
          ),
        );
      }
    );
  }
}