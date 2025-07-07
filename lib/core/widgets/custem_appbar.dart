import 'package:flutter/material.dart';

AppBar custemAppbar({required String heading, required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,

    title: Text(heading, style: Theme.of(context).textTheme.displayMedium),
  );
}
