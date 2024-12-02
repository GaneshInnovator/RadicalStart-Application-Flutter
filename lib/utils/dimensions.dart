import 'package:flutter/material.dart';

class AppDimensions {
  static double paddingHorizontal(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.04;
  static double paddingVertical(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.02;

  static double buttonHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.08;
  static double buttonWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.12;

  static double borderRadius(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.02;

  static double textSizeHeading(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.06;
  static double textSizeSubheading(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05;
  static double textSizeBody(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.04;
  static double textSizeButton(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.045;

  static double logoHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.08;
  static double logoWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.37;

  static double containerHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.33;
  static double containerWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.5;
}
