import 'package:flutter/painting.dart';

class UIColors {
  UIColors._();
  static List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  static List<Color> get maincolor => _maincolor;
  static Color fcolor = _maincolor.first;
  static Color get scolor => _maincolor[1];
}
