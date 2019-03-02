import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Loading...')
        ],
      )
    );
  }
}