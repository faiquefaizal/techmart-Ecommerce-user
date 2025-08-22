import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget summaryRow(
  String title, {
  String? value,
  bool isBold = false,
  Widget? wisget,
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
                  ? GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  )
                  : GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black45,
                    fontWeight: FontWeight.w200,
                  ),
        ),

        (wisget != null)
            ? wisget
            : (value != null)
            ? Text(
              value,
              style:
                  isBold
                      ? GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )
                      : GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
            )
            : SizedBox.shrink(),
      ],
    ),
  );
}
