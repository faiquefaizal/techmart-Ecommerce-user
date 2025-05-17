import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemButton extends StatelessWidget {
  String Label;
  VoidCallback onpressed;
  Widget? child;
  Color color;
  Color textcolor;
  CustemButton({
    required this.Label,
    required this.onpressed,
    this.child,
    this.color = Colors.black,
    this.textcolor = Colors.white,
  });

  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        onPressed: onpressed,
        child:
            child ??
            Text(
              Label,
              style: GoogleFonts.lato(
                color: textcolor,

                fontSize: 25,
                fontWeight: FontWeight.w400,
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
