import 'package:flutter/material.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/controllers/group_controller.dart';

class GroupSearch extends StatelessWidget {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<GroupFormState>!
  static final _formKey = GlobalKey<FormState>();
  final User user;
  final Group group = Group();
  final idFocus = FocusNode();

  GroupSearch(this.user);

  void _fetchGroup(){
    final grp = GroupController.groupsRef.document(group.id).get();
    grp.then((doc) {
      if(!doc.exists){
        //TODO: add warning that group key is invalid (snackbar doesn't work inside a dialog)
      } else {
        final newGroup = Group.fromMap(doc.data);
        newGroup.addMember(user);
        user.addGroup(newGroup);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text("Join Group"),
        content: SingleChildScrollView(
          child: Center(
            child: DefaultField('group key', (value) => group.id = value, idFocus, initValue: '', autoFocus: true),
          )
        ),
        actions: <Widget>[
          forwardButton(context),
          backwardButton(context)
        ],
      ),
    );
  }

  Widget forwardButton(BuildContext context){
    return SubmitButton(_formKey, _fetchGroup);
  }

  Widget backwardButton(BuildContext context){
    return CancelButton();
  }
}