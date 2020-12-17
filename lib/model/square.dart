import 'package:flutter/cupertino.dart';

class Square {
  bool hasBomb;
  bool isOpen;
  bool isFlagged;
  int numberOfBombs;

  Square({
    this.hasBomb = false,
    this.numberOfBombs = 0,
    this.isOpen = false,
    this.isFlagged = false
  });
}