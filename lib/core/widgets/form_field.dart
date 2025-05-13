import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustemTextFIeld extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool password;
  final bool readOnly;
  CustemTextFIeld({
    required this.label,
    required this.hintText,
    required this.controller,
    this.password = false,
    this.readOnly = false,
  });

  @override
  State<CustemTextFIeld> createState() => _CustemTextFIeldState();
}

class _CustemTextFIeldState extends State<CustemTextFIeld> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: _obscureText,

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 253, 253),
            suffixIcon:
                widget.password
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                    : null,
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
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
