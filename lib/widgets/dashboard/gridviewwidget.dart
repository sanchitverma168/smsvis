import 'package:Smsvis/utils/colors.dart';
import 'package:flutter/material.dart';

class GridViewBoxShow extends StatelessWidget {
  final Function function;
  final double heightBox;
  final double widthBox;
  final String text;
  final String data;
  final IconData icondata;
  final Color textColor;
  final double textSize;
  final Color iconColor;
  final double iconSize;
  final Color boxColor;
  GridViewBoxShow(
      {this.textColor = Colors.white,
      this.iconColor = Colors.white,
      this.iconSize = 45.0,
      this.textSize = 32.0,
      this.boxColor,
      @required this.function,
      this.icondata,
      @required this.text,
      this.data,
      @required this.heightBox,
      @required this.widthBox,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          function();
        },
        child: Card(
          color: boxColor != null ? boxColor : UIColors.fcolor,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: heightBox,
              width: widthBox,
              child: Stack(children: [
                data != null
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(data,
                            style: TextStyle(
                                fontSize: textSize,
                                fontWeight: FontWeight.bold,
                                color: textColor)))
                    : Align(
                        alignment: Alignment.center,
                        child: Icon(
                          icondata,
                          size: iconSize,
                          color: iconColor,
                        )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(text,
                        style: TextStyle(fontSize: 16, color: Colors.white)))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
