import 'package:flutter/material.dart';
import 'package:raid_list/widgets/form/buttons.dart';

class ConfirmDialog extends StatelessWidget {

  final String confirmText;
  final Function onConfirm;

  ConfirmDialog(this.confirmText, this.onConfirm);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(confirmText),
      actions: <Widget>[
        ConfirmButton(onConfirm),
        CancelButton()
      ],
    );
  }

}