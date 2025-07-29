import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemAddCoupoupenButton extends StatelessWidget {
  double hieght;
  String label;
  VoidCallback onpressed;
  Widget? child;
  Color color;
  Color textcolor;
  double radius;
  CustemAddCoupoupenButton({
    this.hieght = 60,
    required this.label,
    required this.onpressed,
    this.child,
    this.color = Colors.black,
    this.textcolor = Colors.white,
    this.radius = 5,
  });

  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        onPressed: onpressed,
        child:
            child ??
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: textcolor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
      ),
    );
  }
}
