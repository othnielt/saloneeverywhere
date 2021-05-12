import 'package:flutter/material.dart';

class InputTextform extends StatelessWidget {
  InputTextform(
      {this.label,
      this.onChanged,
      this.obscureText = false,
      this.keybord,
      this.onSaved,
      this.validator,
      this.surfixeIcon,
      this.textStyle,
      this.controller,
      this.autofocus = false});
  final String label;
  final Function onChanged;
  final bool obscureText;
  final keybord;
  final validator;
  final onSaved;
  final Widget surfixeIcon;
  final textStyle;
  final controller;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Text(label ?? "")),
        Container(
          height: 55.0,
          margin: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          decoration: BoxDecoration(color: Colors.white),
          child: TextFormField(
            controller: controller,
            validator: validator,
            onSaved: onSaved,
            keyboardType: keybord,
            autofocus: autofocus,
            textAlign: TextAlign.center,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffix: surfixeIcon,
              suffixStyle: textStyle,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
