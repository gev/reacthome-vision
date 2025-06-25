import 'package:flutter/material.dart';

class Position {
  Offset _position;

  Offset get position => _position;

  Position(Offset position) : _position = position;

  void moveBy(Offset offset) {
    _position += offset;
  }

  void moveTo(Offset offset) {
    _position = offset;
  }
}
