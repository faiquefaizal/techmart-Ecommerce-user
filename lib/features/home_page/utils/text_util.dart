import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static final TextStyle productName = GoogleFonts.anton(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final TextStyle sellingPrice = GoogleFonts.anton(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final TextStyle regularPrice = GoogleFonts.anton(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle discount = GoogleFonts.anton(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static final TextStyle variantAttribute = GoogleFonts.anton(
    fontSize: 18,
    color: Colors.black87,
  );

  static final TextStyle sectionTitle = GoogleFonts.anton(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle description = GoogleFonts.anton(
    fontSize: 16,
    color: Colors.black54,
  );

  static final TextStyle brandName = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  // HomeScreen styles
  static final TextStyle homeProductName = GoogleFonts.anton(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static final TextStyle homeRegularPrice = GoogleFonts.anton(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: 0.2,
  );

  static final TextStyle homeSellingPrice = GoogleFonts.anton(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle homeDiscount = GoogleFonts.anton(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
}
