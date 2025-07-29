import 'package:flutter/material.dart';

class VerticalSpaceWisget extends StatelessWidget {
  final double hieght;
  const VerticalSpaceWisget(this.hieght, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: hieght);
  }
}

class HorizontalSpaceWisget extends StatelessWidget {
  final double width;
  const HorizontalSpaceWisget(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
