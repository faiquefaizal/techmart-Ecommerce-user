import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static final TextStyle cartPrice = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static final TextStyle productName = GoogleFonts.oswald(
    fontSize: 29,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: 1.5,
  );

  static final TextStyle cartCardPrice = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final TextStyle regularPrice = GoogleFonts.poppins(
    fontSize: 33,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final TextStyle sellingPrice = GoogleFonts.poppins(
    fontSize: 18,
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

  static final TextStyle description = TextStyle(
    fontSize: 14,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
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

  static final TextStyle homeSellingPrice = GoogleFonts.poppins(
    fontSize: 11,

    fontWeight: FontWeight.w400,
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
  static const variantAttributeKey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const variantAttributeValue = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}

class CustemTextStyles {
  static const TextStyle headline = TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    letterSpacing: 0.5,
  );

  static const TextStyle subHeadline = TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.2,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle price = TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle discount = TextStyle(
    fontFamily: 'GeneralSans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
