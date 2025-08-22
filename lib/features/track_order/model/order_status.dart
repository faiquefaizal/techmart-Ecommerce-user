import 'package:flutter/material.dart';

enum OrderStatus { Pending, proccessing, shipped, outfordelivery, delivery }

int getIndexWithStatus(String value) {
  switch (value) {
    case "Pending":
      return 0;
    case "proccessing":
      return 1;
    case "shipped":
      return 2;
    case "outfordelivery":
      return 3;
    case "delivery":
      return 4;
    default:
      return 0;
  }
}
