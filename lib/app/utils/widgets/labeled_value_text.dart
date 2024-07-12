import 'package:flutter/material.dart';

class LabeledValueText extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const LabeledValueText({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontSize: 18,
              color: color,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
