import 'package:coding_hands_task/helpers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle tittlefont(
    {double size = 16,
    color = ColorConstants.primaryColor,
    fontweight = FontWeight.w700}) {
  return TextStyle(fontSize: size, color: color, fontWeight: fontweight);
}
