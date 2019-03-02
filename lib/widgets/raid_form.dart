import 'package:flutter/material.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/controllers/raid_controller.dart';

class RaidForm extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<RaidFormState>!
  static final _formKey = GlobalKey<FormState>();
  final Raid raid;
  final Group group;
  final User user;
  final locationFocus = FocusNode();
  final bossFocus = FocusNode();

  RaidForm(this.user, this.group, {this.raid}){
    raid.groupId = group.id;
  }

  void _saveRaid(){
    if(raid.id == null){
      RaidController.create(raid);
      raid.addMember(user);
    } else {
      RaidController.update(raid);
    }
  }

  void _deleteRaid(){
    RaidController.delete(raid);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: title(context),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultField('location', (value) => raid.location = value, locationFocus, initValue: raid.location, autoFocus: false, nextFocus: bossFocus),
              SizedBox(height: 8.0),
              DefaultField('boss', (value) => raid.boss = value, bossFocus, initValue: raid.boss),
            ],
          )
        ),
        actions: <Widget>[
          forwardButton(context),
          backwardButton(context)
        ],
      ),
    );
  }

  Widget title(BuildContext context){
    if(raid.id == null) return Text("Create Raid");
    else return Text("Edit Raid");
  }

  Widget forwardButton(BuildContext context){
    return SubmitButton(_formKey, _saveRaid);
  }

  Widget backwardButton(BuildContext context){
    if(raid.id == null) return CancelButton();
    else return DeleteButton(_formKey, _deleteRaid);
  }
}