import 'package:flutter/material.dart';

class RoundRectangleButton extends StatelessWidget {
  RoundRectangleButton(
      {@required this.color,
      @required this.height,
      @required this.elevation,
      @required this.onPresss,
      @required this.text,
      @required this.minWidth,
      this.style});

  final Color color;
  final double elevation;
  final double height;
  final Function onPresss;
  final String text;
  final double minWidth;
  final style;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: MaterialButton(
        color: color,
        //Color(0xFFA6B3C6),
        minWidth: minWidth,
        height: height,
        //60,
        elevation: elevation,
        //4.0,
        onPressed: onPresss,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        child: Text(text, style: style),
      ),
    );
  }
}
