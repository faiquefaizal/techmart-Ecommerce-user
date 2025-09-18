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

final List<String> steps = [
  "Pending",
  "proccessing",
  "shipped",
  "outfordelivery",
  "delivery",
];

String formatStep(String step) {
  switch (step.toLowerCase()) {
    case "pending":
      return "Pending";
    case "proccessing":
      return "Processing"; // fixed typo
    case "shipped":
      return "Shipped";
    case "outfordelivery":
      return "Out for Delivery";
    case "delivery":
      return "Delivered";
    default:
      return step; // fallback: return as-is
  }
}
