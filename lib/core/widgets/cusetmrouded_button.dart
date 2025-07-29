import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CusetmroudedButton extends StatelessWidget {
  String Label;
  VoidCallback onpressed;
  Widget? child;
  Color color;
  Color textcolor;
  CusetmroudedButton({
    required this.Label,
    required this.onpressed,
    this.child,
    this.color = Colors.black,
    this.textcolor = Colors.white,
  });

  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        onPressed: onpressed,
        child:
            child ??
            Text(
              Label,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: textcolor,

                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
      ),
    );
  }
}
