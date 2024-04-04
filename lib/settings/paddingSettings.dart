import 'package:flutter/material.dart';

abstract class PaddingSetting{
  EdgeInsetsGeometry value(BuildContext context);
}

class PagePadding extends PaddingSetting{
  @override
  EdgeInsetsGeometry value(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.03);
  }
}

class HorizontalPadding extends PaddingSetting{
  @override
  EdgeInsetsGeometry value(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return EdgeInsets.symmetric(horizontal: size.width * 0.03);
  }
}

class VerticalPadding extends PaddingSetting{
  @override
  EdgeInsetsGeometry value(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return EdgeInsets.symmetric(vertical: size.height * 0.03);
  }
}