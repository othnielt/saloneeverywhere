import 'package:flutter/material.dart';

class Flatbutton extends StatelessWidget {
  Flatbutton(
      {@required this.leadingText,
      @required this.titleText,
      @required this.onPressed});
  final String leadingText;
  final String titleText;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: 35), child: Text(leadingText)),
        FlatButton(
          padding: EdgeInsets.only(bottom: 35, right: 50),
          onPressed: onPressed,
          child: Text(titleText,
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
      ],
    );
  }
}
