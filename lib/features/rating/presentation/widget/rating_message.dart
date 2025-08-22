import 'package:flutter/material.dart';

Form ratingTextfield(GlobalKey key) {
  return Form(
    key: key,
    child: TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        hintText: 'Write your review...',

        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      maxLines: 4,
    ),
  );
}
