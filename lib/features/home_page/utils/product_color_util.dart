import 'package:flutter/material.dart';

Color getColorFromString(String color) {
  switch (color.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'gold':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}
