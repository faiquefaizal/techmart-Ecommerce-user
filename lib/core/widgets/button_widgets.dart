import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemButton extends StatelessWidget {
  double hieght;
  final String label;
  VoidCallback? onpressed;
  Widget? child;
  Color color;
  Color textcolor;
  double radius;
  double textSize;
  Color borderColor;
  FontWeight fontWeight;
  EdgeInsets padding;
  CustemButton({
    super.key,
    this.hieght = 50,
    required this.label,
    this.onpressed,
    this.child,
    this.radius = 5,
    this.color = Colors.black,
    this.textcolor = Colors.white,
    this.textSize = 20,
    this.borderColor = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  });

  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: padding,
        ),
        onPressed: onpressed,
        child:
            child ??
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: textcolor,
                fontSize: textSize,
                fontWeight: fontWeight,
              ),
            ),
      ),
    );
  }
}

class CustemDropDown<T> extends StatefulWidget {
  String label;
  List<DropdownMenuItem<T>> items;
  T? seletedValue;
  String? Function(T?)? validator;
  CustemDropDown({
    required this.label,
    required this.items,
    required this.seletedValue,
    this.validator,
  });

  @override
  State<CustemDropDown<T>> createState() => _CustemDropDownState<T>();
}

class _CustemDropDownState<T> extends State<CustemDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          dropdownColor: Colors.white,
          style: TextStyle(color: Colors.black),
          validator: widget.validator,
          value: widget.seletedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          hint: Text("Select your Gender"),
          items: widget.items,
          icon: Icon(Icons.arrow_drop_down_outlined),

          onChanged: (value) {
            setState(() {
              widget.seletedValue = value;
            });
          },
        ),
      ],
    );
  }
}
