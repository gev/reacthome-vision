import 'package:flutter/material.dart';

class Vertex {
  Offset _position;

  Offset get position => _position;

  Vertex(Offset position) : _position = position;

  void moveBy(Offset offset) {
    _position += offset;
  }
}
