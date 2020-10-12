import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UIColors {
  UIColors._();

  static List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  static List<Color> get maincolor => _maincolor;
  static Color fcolor = _maincolor.first;
  static const Color scolor = const Color(0xfff7892b);
  static const Color alertColor = const Color.fromARGB(200, 235, 62, 62);
  static const Color successColor = const Color.fromARGB(200, 152, 190, 60);
  static const Color lightBlue = const Color.fromARGB(200, 80, 167, 217);

  static const Color orange = const Color.fromARGB(200, 255, 165, 0);
  static const Color orangeAvant_Grade =
      const Color.fromARGB(200, 255, 136, 34);
  static const Color orangeBurst = const Color.fromARGB(200, 255, 110, 58);
  static const Color orangeBellPepper = const Color.fromARGB(200, 255, 136, 68);
  static const Color orangeCrush = const Color.fromARGB(200, 255, 119, 51);
  static const Color orangeDrop = const Color.fromARGB(200, 255, 142, 63);
  static const Color orangeGluttony = const Color.fromARGB(200, 255, 119, 34);
  static const Color orangeDelight = const Color.fromARGB(200, 255, 195, 85);
  static const Color orangeDanger = const Color.fromARGB(200, 255, 102, 0);
  static const Color orangeJelly = const Color.fromARGB(200, 255, 194, 5);
}
