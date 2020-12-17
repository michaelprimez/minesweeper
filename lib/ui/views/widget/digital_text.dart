import 'package:flutter/material.dart';

class DigitalText extends StatelessWidget {

  String _text;

  DigitalText(this._text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
          _text,
          style: TextStyle(
              fontSize: 32,
              fontFamily: 'Scoreboard',
              color: Colors.red,
              backgroundColor: Colors.black87
          )
      ),
    );
  }
}
