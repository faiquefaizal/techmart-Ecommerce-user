import 'package:flutter/material.dart';

class AddressTextFieldWidget extends StatelessWidget {
  final String label;
  final String? initialValue;
  final TextInputType? keyboardtype;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final autofocus;
  const AddressTextFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.validator,
    required this.label,
    this.autofocus = false,
    this.keyboardtype,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        autofocus: autofocus,
        keyboardType: keyboardtype,
        validator: validator,
        initialValue: initialValue,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(12),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: label,
        ),
      ),
    );
  }
}
