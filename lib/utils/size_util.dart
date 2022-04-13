import 'package:flutter/material.dart';

class SizeUtil {
  SizeUtil._();

  static late BuildContext _context;

  static void init(BuildContext context) {
    _context = context;
  }

  static const double _designHeight = 772;
  static const double _designWidth = 360;

  static double height(num size) {
    return (_designHeight / MediaQuery.of(_context).size.height) * size;
  }

  static double width(num size) {
    return (_designWidth / MediaQuery.of(_context).size.width) * size;
  }

  static double textSize(num size) {
    return (_designWidth / MediaQuery.of(_context).size.width) * size;
  }
}

extension SizeUtilExtension on num {
  double get w => SizeUtil.width(this);
  double get h => SizeUtil.height(this);
  double get sp => SizeUtil.textSize(this);
}
