import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static final TextStyle productName = GoogleFonts.oswald(
    fontSize: 29,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: 1.5,
  );

  static final TextStyle regularPrice = GoogleFonts.anton(
    fontSize: 38,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final TextStyle sellingPrice = GoogleFonts.anton(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle discount = GoogleFonts.anton(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static final TextStyle variantAttribute = GoogleFonts.oswald(
    fontSize: 18,
    color: Colors.black87,
  );

  static final TextStyle sectionTitle = GoogleFonts.oswald(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle description = GoogleFonts.oswald(
    fontSize: 16,
    color: Colors.black54,
  );

  static final TextStyle brandName = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  // HomeScreen styles
  static final TextStyle homeProductName = GoogleFonts.oswald(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.3,
  );

  static final TextStyle homeSellingPrice = GoogleFonts.anton(
    fontSize: 18,

    fontWeight: FontWeight.w600,
    color: Colors.grey,
    letterSpacing: 0.1,
  );

  static final TextStyle homeRegularPrice = GoogleFonts.anton(
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
