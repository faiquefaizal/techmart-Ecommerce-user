import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedPriceWidget extends StatelessWidget {
  const AnimatedPriceWidget({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      value: int.parse(total.toString()),
      thousandSeparator: ",",
      prefix: '₹',
      textStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),

      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}
