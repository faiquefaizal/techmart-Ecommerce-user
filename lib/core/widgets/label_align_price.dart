import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class LabelAlignPriceWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  const LabelAlignPriceWidget({
    super.key,
    required this.value,
    required this.label,

    this.textColor = Colors.black,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        AnimatedFlipCounter(
          value: int.parse(value),
          thousandSeparator: ",",
          prefix: '₹',
          textStyle: TextStyle(fontSize: 18),

          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
        ),
      ],
    );
  }
}

class HeadLabelAlignPriceWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final String value;

  const HeadLabelAlignPriceWidget({
    super.key,

    required this.value,
    required this.label,

    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        AnimatedFlipCounter(
          value: int.parse(value),
          thousandSeparator: ",",
          prefix: '₹',
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
        ),
      ],
    );
  }
}
