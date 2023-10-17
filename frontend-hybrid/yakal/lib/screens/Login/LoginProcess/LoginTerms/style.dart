import 'package:flutter/material.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class LoginTermsStyle {
  static const boldTitle = TextStyle(
    color: ColorStyles.black,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const title = TextStyle(
    color: ColorStyles.black,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const checkedAll = TextStyle(
    color: ColorStyles.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.685,
  );

  static const checkedRequired = TextStyle(
    color: ColorStyles.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.685,
  );

  static const checkedOptional = TextStyle(
    color: ColorStyles.sub1,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.685,
  );
}
