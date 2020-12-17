import 'dart:async';

import 'package:flutter/material.dart';

import 'digital_text.dart';

class Clock extends StatelessWidget {

  final int _seconds;

  const Clock(this._seconds);

  @override
  Widget build(BuildContext context) {
    return DigitalText("$_seconds".padLeft(3, "0"));
  }
}

