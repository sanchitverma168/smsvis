import 'package:flutter/cupertino.dart';

class MISReportProvider with ChangeNotifier {
  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];
}
