import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/price_formater.dart';

Widget summaryRow(
  String title, {
  num? value,
  bool isBold = false,
  String? label,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              isBold
                  ? GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  )
                  : GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
        ),

        (value != null)
            ? (isBold)
                ? Text(
                  formatIndianPrice(value.toInt()),
                  style:
                      isBold
                          ? GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )
                          : GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                )
                : Text(
                  (value.toDouble().toStringAsFixed(2)).toString(),
                  style:
                      isBold
                          ? GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )
                          : GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                )
            : Text(
              label!,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
      ],
    ),
  );
}
