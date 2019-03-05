import 'package:flutter/material.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/controllers/group_controller.dart';

class GroupForm extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<GroupFormState>!
  static final _formKey = GlobalKey<FormState>();
  final Group group;
  final User user;
  final nameFocus = FocusNode();
  final descFocus = FocusNode();

  GroupForm(this.user, {this.group});

  void _saveGroup(){
    if(group.id == null){
      GroupController.create(group);
      GroupController.addMember(group, user);
      user.addGroup(group);
    } else {
      GroupController.update(group);
    }
  }

  void _deleteGroup(){
    GroupController.delete(group);
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
              DefaultField('name', (value) => group.name = value, nameFocus, initValue: group.name, nextFocus: descFocus),
              SizedBox(height: 8.0),
              DefaultField('description', (value) => group.description = value, descFocus, initValue: group.description),
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
    if(group.id == null) return Text("Create Group");
    else return Text("Edit Group");
  }

  Widget forwardButton(BuildContext context){
    return SubmitButton(_formKey, _saveGroup);
  }

  Widget backwardButton(BuildContext context){
    if(group.id == null) return CancelButton();
    else return DeleteButton(_formKey, _deleteGroup);
  }
}